#include "DisplayCommunicator.h"

void DisplayCommunicator::setup() {
  std::string oscTestAddr = ofToString(getenv("OSC_TEST_SERVER_ADDR"));
  int oscTestPort = ofToInt(ofToString(getenv("OSC_TEST_SERVER_PORT")));
  _oscTestSender.setup(oscTestAddr, oscTestPort);

  ofxOscMessage testMessage;
  testMessage.setAddress("/displays/test");
  testMessage.addInt32Arg(69);
  _oscTestSender.sendMessage(testMessage, false);

  std::string asciiDisplayAddr = getenv("ASCII_DISPLAY_SERVER_ADDR");
  int asciiDisplayPort = ofToInt(getenv("ASCII_DISPLAY_SERVER_PORT"));
  _asciiDisplaySender.setup(asciiDisplayAddr, asciiDisplayPort);

  std::string faceDisplayAddr = getenv("FACE_POINTS_DISPLAY_SERVER_ADDR");
  int faceDisplayPort = ofToInt(getenv("ASCII_DISPLAY_SERVER_PORT"));
  _faceDisplaySender.setup(faceDisplayAddr, faceDisplayPort);

  std::string genderDisplayAddr = getenv("GENDER_DISPLAY_SERVER_ADDR");
  int genderDisplayPort = ofToInt(getenv("ASCII_DISPLAY_SERVER_PORT"));
  _genderDisplaySender.setup(genderDisplayAddr, genderDisplayPort);
  
  std::string emotionDisplayAddr = getenv("EMOTION_DISPLAY_SERVER_ADDR");
  int emotionDisplayPort = ofToInt(getenv("ASCII_DISPLAY_SERVER_PORT"));
  _emotionDisplaySender.setup(emotionDisplayAddr, emotionDisplayPort);
  
  std::string listDisplayAddr = getenv("LIST_DISPLAY_SERVER_ADDR");
  int listDisplayPort = ofToInt(getenv("ASCII_DISPLAY_SERVER_PORT"));
  _listDisplaySender.setup(listDisplayAddr, listDisplayPort);
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