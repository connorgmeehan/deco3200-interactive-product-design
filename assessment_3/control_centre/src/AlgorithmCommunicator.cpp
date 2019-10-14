#pragma once

#include "AlgorithmCommunicator.h"

void AlgorithmCommunicator::setup() {
  _baseUri = ofToString("http://127.0.0.1:8001");
}

void AlgorithmCommunicator::update() {
  
}

void AlgorithmCommunicator::draw() {

}

void AlgorithmCommunicator::sendRoi(uint64_t uid, ofImage& roi) {
  ofLog() << "\n\n\n\nAlgorithmCommunicator::sendRoi(uint64_t uid: " << uid << ");";

  std::string uri = _baseUri + "/add_roi";
  
  ofxHTTP::PostRequest request(uri);
  // Build data pack
  std::multimap<std::string, std::string> formFields =
  {
      { "uid", ofToString(uid) },
  };
  request.addFormFields(formFields);
  
  char * roiPixels = (char *) roi.getPixels().getData();
  size_t size = roi.getPixels().size();
  ofLog() << "\tAlgorithmCommunicator::sendRoi(...) -> roi.size(): " << size * sizeof(char);

  std::string encoding = ofxIO::Base64Encoding::encode(ofBuffer(roiPixels, size));
  ofx::HTTP::FormPart roiFormPart(ofx::HTTP::FormPart::Type::STRING, "roi", encoding);
  request.addFormPart(roiFormPart);

  _executePostRequest(request);
}

void AlgorithmCommunicator::clearRois() {
  ofLog() << "AlgorithmCommunicator::clearRois();";
  std::string uri = _baseUri + "/clear_rois";
  ofxHTTP::PostRequest request(uri);
  _executePostRequest(request);
}

bool AlgorithmCommunicator::_executePostRequest(ofx::HTTP::PostRequest& request) {
  ofLog() << "AlgorithmCommunicator::_executePostRequest()";
  ofLog() << "\turi: " << request.getURI();

  ofx::HTTP::Client client;
  try {
    // Execute the request.
    auto response = client.execute(request);
    ofLog() << "response status " << Poco::Net::HTTPResponse::HTTP_OK;
    // Check the response.
    if (response->getStatus() == Poco::Net::HTTPResponse::HTTP_OK)
    {
      // A successful response.
      ofLogNotice("ofApp::setup") << "Response success, expecting " << response->estimatedContentLength() << " bytes.";
      return true;
    }
  } catch (const Poco::Exception& exc) {
    ofLogError("ofApp::setup") << exc.displayText();
  } catch (const std::exception& exc) {
    ofLogError("ofApp::setup") << exc.what();
  }
  return false;
}

std::function<void(uint64_t, ofImage&)> AlgorithmCommunicator::getSendRoiCallback() {
  return std::bind(&AlgorithmCommunicator::sendRoi, this, std::placeholders::_1, std::placeholders::_2);
}