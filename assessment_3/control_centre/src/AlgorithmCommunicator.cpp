#pragma once

#include "AlgorithmCommunicator.h"

AlgorithmCommunicator::~AlgorithmCommunicator() {  
  _fifoWriteThread.stopThread();
  ofxFifo::del(_fifoWriteThread.pipe_dir);
}

void AlgorithmCommunicator::setup() {
  ofLog() << "AlgorithmCommunicator::setup()";
  _recieverPort = ofToInt(ofToString(getenv("CONTROL_CENTRE_RECIEVER_PORT")));
  _recogniserServerPort = ofToInt(ofToString(getenv("RECOGNISER_SERVER_PORT")));

  _fifoWriteThread.pipe_dir = ofToString(getenv("VID_OUT_DIR"));
  _fifoWriteThread.startThread();

  ofLog() << "\tstarting control centre's OSC sender for the recogniser, targetting host: " << _host << " on port: " << _recogniserServerPort;
  _recogniserSender.setup(_host, _recogniserServerPort);
  ofLog() << "\tstarting control panels's OSC reciever on port:" << _recieverPort;
  _reciever.setup(_recieverPort);
}

void AlgorithmCommunicator::update() {
  while(_reciever.hasWaitingMessages()) {
    ofxOscMessage message;
    _reciever.getNextMessage(message);
    ofLog() << "Reciever() -> new message at address: " << message.getAddress();
    if (message.getAddress() == "/display/detected") {
      int uid = message.getArgAsInt32(0);
      ofLog() << "User Detected uid: " << uid;
      _handleUserDetected(uid, false);
    }

    if (message.getAddress() == "/display/demographic") {
      int uid = message.getArgAsInt32(0);
      bool isMale = message.getArgAsBool(1);
      int age = message.getArgAsInt32(2);
      _handleUserDemographic(uid, isMale, age);
    }

    if(message.getAddress() == "/display/ascii") {
      int uid = message.getArgAsInt32(0);
      std::string ascii = message.getArgAsString(1);
      _handleUserASCII(uid, ascii);
    }
  }
}

void AlgorithmCommunicator::draw() {

}

void AlgorithmCommunicator::sendRoi(uint64_t uid, ofImage& roi) {
  ofLog() << "\nAlgorithmCommunicator::sendRoi(uint64_t uid: " << uid << ");";
  
  // Send image over FIFO
  _fifoWriteThread.setPixels(roi);

  // Send OSC
  ofxOscMessage recogniserMessage;
  recogniserMessage.setAddress("/algorithm/roi");
  recogniserMessage.addInt32Arg(uid);
  recogniserMessage.addInt32Arg(roi.getWidth());
  recogniserMessage.addInt32Arg(roi.getHeight());
  _recogniserSender.sendMessage(recogniserMessage, false);
}

void AlgorithmCommunicator::clearRois() {
  // Send OSC
  ofxOscMessage recogniserMessage;
  recogniserMessage.setAddress("/algorithm/clear_all");
  _displayViewModel = DisplayVM();
}

std::function<void(uint64_t, ofImage&)> AlgorithmCommunicator::getSendRoiCallback() {
  return std::bind(&AlgorithmCommunicator::sendRoi, this, std::placeholders::_1, std::placeholders::_2);
}

void AlgorithmCommunicator::_handleUserDetected(int uid, bool isNew) {
  ofLog() << "User Detected uid: " << uid << ", isNew: " << (isNew ? "true" : "false");

  _displayViewModel.uid = uid;
  if(isNew) {
    ofxOscMessage asciiMessage;
    asciiMessage.setAddress("/algorith/ascii");
    asciiMessage.addInt32Arg(_lastWidth);
    asciiMessage.addInt32Arg(_lastHeight);
    _asciiSender.sendMessage(asciiMessage, false);
  }
}

void AlgorithmCommunicator::_handleUserDemographic(int uid, bool isMale, int age) {
  ofLog() << "AlgorithmCommunicator::_handleUserDemographic(uid: " << uid << ", isMale: " << (isMale ? "true" : "false") << ", age: " << age << ");";
  if(_displayViewModel.uid == uid) {
    _displayViewModel.isMale = isMale;
    _displayViewModel.age = age;
  }
}

void AlgorithmCommunicator::_handleUserASCII(int uid, std::string& ascii) {
  ofLog() << "AlgorithmCommunicator::_handleUserASCII(uid: " << uid << ", ascii:\n" << ascii << "\n);";
  if(_displayViewModel.uid == uid) {
    _displayViewModel.ascii = ascii;
  }
}