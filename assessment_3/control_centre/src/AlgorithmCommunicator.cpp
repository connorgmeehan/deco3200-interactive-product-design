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
    if (message.getAddress() == "/user/detected") {
      int uid = message.getArgAsInt32(0);
      ofLog() << "User Detected uid: " << uid;
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
  recogniserMessage.setAddress("/roi/add_new");
  recogniserMessage.addInt32Arg(uid);
  recogniserMessage.addInt32Arg(roi.getWidth());
  recogniserMessage.addInt32Arg(roi.getHeight());
  _recogniserSender.sendMessage(recogniserMessage, false);
}

void AlgorithmCommunicator::clearRois() {
  // Send OSC
  ofxOscMessage recogniserMessage;
  recogniserMessage.setAddress("/roi/clear_all");
}

std::function<void(uint64_t, ofImage&)> AlgorithmCommunicator::getSendRoiCallback() {
  return std::bind(&AlgorithmCommunicator::sendRoi, this, std::placeholders::_1, std::placeholders::_2);
}