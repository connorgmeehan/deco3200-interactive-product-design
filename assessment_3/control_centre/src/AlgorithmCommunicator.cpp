#pragma once

#include "AlgorithmCommunicator.h"

AlgorithmCommunicator::~AlgorithmCommunicator() {  
  _fifoWriteThread.stopThread();
  ofxFifo::del(_fifoWriteThread.pipe_dir);
}

void AlgorithmCommunicator::setup(DisplayCommunicator* pDisplayCommunicator) {
  _pDisplayCommunicator = pDisplayCommunicator;
  
  ofLog() << "AlgorithmCommunicator::setup()";
  _recieverPort = ofToInt(ofToString(getenv("CONTROL_CENTRE_RECIEVER_PORT")));
  _recogniserServerPort = ofToInt(ofToString(getenv("RECOGNISER_SERVER_PORT")));
  _asciiServerPort = ofToInt(ofToString(getenv("ASCII_SERVER_PORT")));
  _emotionServerPort = ofToInt(ofToString(getenv("EMOTION_SERVER_PORT")));
  _demographicServerPort = ofToInt(ofToString(getenv("DEMOGRAPHIC_SERVER_PORT")));

  _fifoWriteThread.pipe_dir = ofToString(getenv("VID_OUT_DIR"));
  _fifoWriteThread.startThread();

  ofLog() << "\tstarting control centre's OSC sender for the recogniser, targetting host: " << _host << " on port: " << _recogniserServerPort;
  _recogniserSender.setup(_host, _recogniserServerPort);
  _asciiSender.setup(_host, _asciiServerPort);
  _emotionSender.setup(_host, _emotionServerPort);
  _demographicSender.setup(_host, _demographicServerPort);
  ofLog() << "\tstarting control panels's OSC reciever on port:" << _recieverPort;
  _reciever.setup(_recieverPort);

  _lastUserDetectTime = ofGetElapsedTimef();
}

void AlgorithmCommunicator::update() {
  while(_reciever.hasWaitingMessages()) {
    ofxOscMessage message;
    _reciever.getNextMessage(message);
    ofLog() << "Reciever() -> new message at address: " << message.getAddress();
    if (message.getAddress() == "/control/detected") {
      int uid = message.getArgAsInt32(0);
      int isNew = message.getArgAsBool(1);
      ofLog() << "User Detected uid: " << uid;
      _handleUserDetected(uid, isNew);
      _pDisplayCommunicator->handleUserDetected(uid, isNew, _getFaceTrackingFeatures(), _lastGreyscale);
    }

    if (message.getAddress() == "/control/demographic") {
      int uid = message.getArgAsInt32(0);
      int age = message.getArgAsFloat(1);
      bool isMale = message.getArgAsBool(2);
      _pDisplayCommunicator->handleUserDemographic(uid, age, isMale);
    }

    if (message.getAddress() == "/control/emotion") {
      int uid = message.getArgAsInt32(0);
      std::string emotion = message.getArgAsString(1);
      _pDisplayCommunicator->handleUserEmotion(uid, emotion);
    }

    if(message.getAddress() == "/control/ascii") {
      int uid = message.getArgAsInt32(0);
      std::string ascii = message.getArgAsString(1);
      _pDisplayCommunicator->handleUserASCII(uid, ascii);
    }
  }
}

void AlgorithmCommunicator::draw() {

}

void AlgorithmCommunicator::sendRoi(uint64_t uid, ofImage& roi, ofImage& greyscale) {
  ofLog() << "\nAlgorithmCommunicator::sendRoi(uint64_t uid: " << uid << ") to " << _host << ":" << _recogniserServerPort;
  if(ofGetElapsedTimef() > _lastUserDetectTime + _userDetectInterval) {
    _lastGreyscale = greyscale;

    // Save last roi's dimensions
    _lastWidth = roi.getWidth();
    _lastHeight = roi.getHeight();

    // Send image over FIFO
    _fifoWriteThread.setPixels(roi);

    // Send OSC to recogniser
    ofxOscMessage recogniserMessage;
    recogniserMessage.setAddress("/algorithm/roi");
    recogniserMessage.addInt32Arg(uid);
    recogniserMessage.addInt32Arg(roi.getWidth());
    recogniserMessage.addInt32Arg(roi.getHeight());
    _recogniserSender.sendMessage(recogniserMessage, false);
  } else {
    ofLog() << "\t user detected at "<<ofGetElapsedTimef()<<" before time... "<<_lastUserDetectTime + _userDetectInterval<<" skipping...";
  }
}

void AlgorithmCommunicator::clearRois() {
  // Send OSC
  ofxOscMessage recogniserMessage;
  recogniserMessage.setAddress("/algorithm/clear_all");
}

void AlgorithmCommunicator::setFaceTrackingFeaturesGetter(std::function<std::vector<ofPolyline>()> getter) {
  _getFaceTrackingFeatures = getter;
}

void AlgorithmCommunicator::_handleUserDetected(int uid, bool isNew) {
  ofLog() << "User Detected uid: " << uid << ", isNew: " << (isNew ? "true" : "false");
  if(isNew) {
    _lastUserDetectTime = ofGetElapsedTimef();
    _lastUid = uid;
    ofLog() << "\tSending ascii to " << _host << ":" << _asciiServerPort << "...";
    ofxOscMessage asciiMessage;
    asciiMessage.setAddress("/algorithm/ascii");
    asciiMessage.addInt32Arg(_lastUid);
    asciiMessage.addInt32Arg(_lastWidth);
    asciiMessage.addInt32Arg(_lastHeight);
    _asciiSender.sendMessage(asciiMessage, false);

    ofLog() << "\tSending emotion to " << _host << ":" << _emotionServerPort << "...";
    ofxOscMessage emotionMessage;
    emotionMessage.setAddress("/algorithm/emotion");
    emotionMessage.addInt32Arg(_lastUid);
    emotionMessage.addInt32Arg(_lastWidth);
    emotionMessage.addInt32Arg(_lastHeight);
    _emotionSender.sendMessage(emotionMessage, false);

    ofLog() << "\tSending demographic to " << _host << ":" << _demographicServerPort << "...";
    ofxOscMessage demographicMessage;
    demographicMessage.setAddress("/algorithm/demographic");
    demographicMessage.addInt32Arg(_lastUid);
    demographicMessage.addInt32Arg(_lastWidth);
    demographicMessage.addInt32Arg(_lastHeight);
    _demographicSender.sendMessage(demographicMessage, false);   
  }
}