#pragma once

#include "AlgorithmCommunicator.h"

AlgorithmCommunicator::~AlgorithmCommunicator() {  
  _fifoWriteThread.stopThread();
  ofxFifo::del(_fifoWriteThread.pipe_dir);
}

void AlgorithmCommunicator::setup() {
  ofLog() << "AlgorithmCommunicator::setup()";
  std::string recogniserPortString = ofToString(getenv("RECOGNISER_PORT"));
  std::string videoOutDir = ofToString(getenv("VID_OUT_DIR"));
  _recogniserPort = ofToInt(recogniserPortString);

  _fifoWriteThread.pipe_dir = videoOutDir;
  _fifoWriteThread.startThread();

  _recogniserSender.setup(_host, _recogniserPort);
}

void AlgorithmCommunicator::update() {
  
}

void AlgorithmCommunicator::draw() {

}

void AlgorithmCommunicator::sendRoi(uint64_t uid, ofImage& roi) {
  ofLog() << "\n\n\n\nAlgorithmCommunicator::sendRoi(uint64_t uid: " << uid << ");";
  
  // Send image over FIFO
  _fifoWriteThread.lock();
  roi.getTexture().readToPixels(_fifoWriteThread.pixels);
  _fifoWriteThread.unlock();  

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