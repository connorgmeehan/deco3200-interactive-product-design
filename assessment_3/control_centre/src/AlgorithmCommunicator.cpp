#pragma once

#include "AlgorithmCommunicator.h"

void AlgorithmCommunicator::setup() {
}

void AlgorithmCommunicator::update() {
  
}

void AlgorithmCommunicator::draw() {

}

void AlgorithmCommunicator::sendRois(uint64_t uid, std::vector<ofImage>& rois) {
  std::string uri = "https://httpbin.org/post";

  // Build data pack
  std::multimap<std::string, std::string> formFields =
  {
      { "uid", ofToString(uid) },
  };
  // add 'roi' field for each roi
  for(int i = 0; i < rois.size(); i++) {
    char * roiPixels = (char *) rois[i].getPixels().getData();
    size_t size = rois[i].getPixels().size();
    formFields.insert(
      std::pair<std::string, std::string>(
        "roi" + ofToString(i),
        ofxIO::Base64Encoding::encode(ofBuffer(roiPixels, size))
      )
    );
  }

  ofxHTTP::PostRequest request(uri);

  try {
    // Execute the request.
    auto response = _client.execute(request);
    
    // Check the response.
    if (response->getStatus() == Poco::Net::HTTPResponse::HTTP_OK)
    {
      // A successful response.
      ofLogNotice("ofApp::setup") << "Response success, expecting " << response->estimatedContentLength() << " bytes.";
    }
  } catch (const Poco::Exception& exc) {
    ofLogError("ofApp::setup") << exc.displayText();
  } catch (const std::exception& exc) {
    ofLogError("ofApp::setup") << exc.what();
  }

}

std::function<void(uint64_t, std::vector<ofImage>&)> AlgorithmCommunicator::getSendRoisCallback() {
  return std::bind(&AlgorithmCommunicator::sendRois, this, std::placeholders::_1, std::placeholders::_2);
}