#pragma once

#include "AlgorithmCommunicator.h"

void AlgorithmCommunicator::setup() {
    ofx::HTTP::JSONRPCServerSettings settings;
    settings.setPort(8197);

    // Initialize the server.
    server.setup(settings);
}

void AlgorithmCommunicator::update() {
  
}

void AlgorithmCommunicator::draw() {

}

void AlgorithmCommunicator::sendRois(uint64_t uid, std::vector<ofImage>& rois) {

}

std::function<void(uint64_t, std::vector<ofImage>&)> AlgorithmCommunicator::getSendRoisCallback() {
  return std::bind(&AlgorithmCommunicator::sendRois, this, std::placeholders::_1, std::placeholders::_2);
}