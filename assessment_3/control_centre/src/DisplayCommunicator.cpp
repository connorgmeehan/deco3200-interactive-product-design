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

void DisplayCommunicator::handleUserEmotion(int uid, std::string emotion) {
  ofLog() << "DisplayCommunicator::_handleUserEmotion(uid: " << uid << ", emotion: " << emotion << ");";
  if(_displayViewModel.uid == uid) {
    _displayViewModel.emotion = emotion;
  }
  _trySendModelToDisplays();
}

void DisplayCommunicator::handleUserDemographic(int uid, int age, bool isMale) {
  ofLog() << "DisplayCommunicator::_handleUserDemographic(uid: " << uid << ", isMale: " << (isMale ? "true" : "false") << ", age: " << age << ");";
  if(_displayViewModel.uid == uid) {
    _displayViewModel.isMale = isMale;
    _displayViewModel.age = age;
  }
}

void DisplayCommunicator::handleUserASCII(int uid, std::string& ascii) {
  ofLog() << "DisplayCommunicator::_handleUserASCII(uid: " << uid << ", ascii.size(): " << ascii.size() << ");";
  if(_displayViewModel.uid == uid) {
    _displayViewModel.ascii = ascii;
  }
}

void DisplayCommunicator::trySendModelToDisplays() {
  if(_displayViewModel.isReadyToBeSent()) {
    _sendModelCallback(_displayViewModel);
  }
}