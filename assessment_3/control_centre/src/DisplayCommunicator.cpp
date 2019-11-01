#include "DisplayCommunicator.h"

void DisplayCommunicator::setup() {
  _oscTestAddr = ofToString(getenv("OSC_TEST_SERVER_ADDR"));
  _oscTestPort = ofToInt(ofToString(getenv("OSC_TEST_SERVER_PORT")));
  _oscTestSender.setup(_oscTestAddr, _oscTestPort);

  ofxOscMessage testMessage;
  testMessage.setAddress("/displays/test");
  testMessage.addInt32Arg(69);
  _oscTestSender.sendMessage(testMessage, false);
}

void DisplayCommunicator::update() {

}

void DisplayCommunicator::draw() {

}

void DisplayCommunicator::sendModelToDisplays(DisplayVM& viewModel) {
  
}