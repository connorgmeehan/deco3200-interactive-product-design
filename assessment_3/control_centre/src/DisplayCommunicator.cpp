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

void DisplayCommunicator::handleUserDetected(int uid, bool isNew, std::vector<ofPolyline> lines) {
  _checkIfNewUid(uid);
  _displayViewModel.detectedState = isNew ? DetectedState::NEW : DetectedState::OLD;
  _displayViewModel.features = lines;
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

  std::vector<std::string> encodedFeatures(_displayViewModel.features.size());
  for(int i = 0; i < encodedFeatures.size(); i++) {
    encodedFeatures[i] = _encodePolyline(_displayViewModel.features[i]);
  }
  
  ofxOscMessage asciiMessage;
  asciiMessage.setAddress("/display/ascii");
  asciiMessage.addInt32Arg(_displayViewModel.uid);
  asciiMessage.addStringArg(_displayViewModel.ascii);
  _asciiDisplaySender.sendMessage(asciiMessage, false);
  ofLog() << "_asciiDisplaySender.sendMessage() -> to " << _asciiDisplaySender.getHost() << ":" << _asciiDisplaySender.getPort();

  ofxOscMessage faceMessage;
  faceMessage.setAddress("/display/face");
  faceMessage.addInt32Arg(_displayViewModel.uid);
  faceMessage.addInt32Arg(_displayViewModel.age);
  for(auto & feature : encodedFeatures) {
    faceMessage.addStringArg(feature);
  }
  _faceDisplaySender.sendMessage(faceMessage, false);
  ofLog() << "_faceDisplaySender.sendMessage() -> to " << _faceDisplaySender.getHost() << ":" << _faceDisplaySender.getPort();

  ofxOscMessage genderMessage;
  genderMessage.setAddress("/display/face");
  genderMessage.addInt32Arg(_displayViewModel.uid);
  genderMessage.addInt32Arg(_displayViewModel.isMale);
  for(auto & feature : encodedFeatures) {
    genderMessage.addStringArg(feature);
  }
  _genderDisplaySender.sendMessage(genderMessage, false);
  ofLog() << "_genderDisplaySender.sendMessage() -> to " << _genderDisplaySender.getHost() << ":" << _genderDisplaySender.getPort();

  ofxOscMessage emotionMessage;
  emotionMessage.setAddress("/display/emotion");
  emotionMessage.addInt32Arg(_displayViewModel.uid);
  emotionMessage.addStringArg(_displayViewModel.emotion);
  _emotionDisplaySender.sendMessage(emotionMessage, false);
  ofLog() << "_emotionDisplaySender.sendMessage() -> to " << _emotionDisplaySender.getHost() << ":" << _emotionDisplaySender.getPort();

  ofxOscMessage listMessage;
  listMessage.setAddress("/display/list");
  listMessage.addInt32Arg(_displayViewModel.uid);
  _listDisplaySender.sendMessage(listMessage, false);
  ofLog() << "_listDisplaySender.sendMessage() -> to " << _listDisplaySender.getHost() << ":" << _listDisplaySender.getPort();
}

std::string DisplayCommunicator::_encodePolyline(ofPolyline & polyline) {
  std::string encodedPolyline;
  encodedPolyline.resize(polyline.size() * sizeof(float) * 2);
  for(int i = 0; i < polyline.size(); i++) {
    auto & curVec = polyline.getVertices()[i];
    memcpy(&curVec.x, &encodedPolyline[i * sizeof(float) * 2], sizeof(float));
    memcpy(&curVec.y, &encodedPolyline[i * sizeof(float) * 2 + 1], sizeof(float));
  }
  return encodedPolyline;
}