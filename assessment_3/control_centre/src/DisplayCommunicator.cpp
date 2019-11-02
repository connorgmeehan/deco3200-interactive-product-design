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

void DisplayCommunicator::handleUserDetected(int uid, bool isNew) {
  _checkIfNewUid(uid);
  _displayViewModel.detectedState = isNew ? DetectedState::NEW : DetectedState::OLD;
  _trySendModelToDisplays();
}

void DisplayCommunicator::handleUserEmotion(int uid, std::string emotion) {
  ofLog() << "DisplayCommunicator::_handleUserEmotion(uid: " << uid << ", emotion: " << emotion << ");";
  _checkIfNewUid(uid);
    _displayViewModel.emotion = emotion;
  _trySendModelToDisplays();
}

void DisplayCommunicator::handleUserDemographic(int uid, int age, bool isMale) {
  ofLog() << "DisplayCommunicator::_handleUserDemographic(uid: " << uid << ", isMale: " << (isMale ? "true" : "false") << ", age: " << age << ");";
  _checkIfNewUid(uid);
  _displayViewModel.isMale = isMale;
  _displayViewModel.age = age;
  _trySendModelToDisplays();
}

void DisplayCommunicator::handleUserASCII(int uid, std::string& ascii) {
  ofLog() << "DisplayCommunicator::_handleUserASCII(uid: " << uid << ", ascii.size(): " << ascii.size() << ");";
  _checkIfNewUid(uid);
  _displayViewModel.ascii = ascii;
  _trySendModelToDisplays();
}

bool DisplayCommunicator::_checkIfNewUid(int uid) {
  if(_displayViewModel.uid == uid) {
    return false;
  } 
  _displayViewModel = DisplayVM(uid);
  return true;
}

void DisplayCommunicator::_trySendModelToDisplays() {
  if(_displayViewModel.isReadyToBeSent()) {
    _sendModel(_displayViewModel);
  }
}

void DisplayCommunicator::_sendModel(DisplayVM& viewModel) {
  ofLog() << "\n\n\nSending model to displays...";
}