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
  int faceDisplayPort = ofToInt(getenv("FACE_POINTS_DISPLAY_SERVER_PORT"));
  _faceDisplaySender.setup(faceDisplayAddr, faceDisplayPort);

  std::string genderDisplayAddr = getenv("GENDER_DISPLAY_SERVER_ADDR");
  int genderDisplayPort = ofToInt(getenv("GENDER_DISPLAY_SERVER_PORT"));
  _genderDisplaySender.setup(genderDisplayAddr, genderDisplayPort);
  
  std::string emotionDisplayAddr = getenv("EMOTION_DISPLAY_SERVER_ADDR");
  int emotionDisplayPort = ofToInt(getenv("EMOTION_DISPLAY_SERVER_PORT"));
  _emotionDisplaySender.setup(emotionDisplayAddr, emotionDisplayPort);
  
  std::string listDisplayAddr = getenv("LIST_DISPLAY_SERVER_ADDR");
  int listDisplayPort = ofToInt(getenv("LIST_DISPLAY_SERVER_PORT"));
  _listDisplaySender.setup(listDisplayAddr, listDisplayPort);
}

void DisplayCommunicator::update() {

}

void DisplayCommunicator::draw() {
  if(_displayViewModel.greyscale.getHeight() > 0) {
    _displayViewModel.greyscale.draw(500, 500);
  }
  if(lastGreyscale.getHeight() > 0) {
    lastGreyscale.draw(600, 500);
  }
}

void DisplayCommunicator::handleUserDetected(int uid, bool isNew, std::vector<ofPolyline> lines, ofImage& greyscale) {
  _checkIfNewUid(uid);
  _displayViewModel.greyscale = greyscale;
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
  ofLog() << "Converting pixels to buffer, pixeltype: " << viewModel.greyscale.getPixels().getPixelFormat() << " size: " << viewModel.greyscale.getPixels().size() << " pixelSize: " << viewModel.greyscale.getPixels().getBytesPerPixel();
  ofBuffer greyscaleBuffer;
  ofSaveImage(viewModel.greyscale.getPixels(), greyscaleBuffer, ofImageFormat::OF_IMAGE_FORMAT_JPEG, ofImageQualityType::OF_IMAGE_QUALITY_WORST);
  
  lastGreyscale.setFromPixels((const unsigned char *) greyscaleBuffer.getData(), 150, 150, ofImageType::OF_IMAGE_GRAYSCALE);
  lastGreyscale.update();

  std::string fakeId = _generateRandomString(16);
  ofLog() << "Fake ID: " << fakeId;
  
  ofxOscMessage asciiMessage;
  asciiMessage.setAddress("/display/ascii");
  asciiMessage.addInt32Arg(_displayViewModel.uid);
  asciiMessage.addStringArg(fakeId);
  asciiMessage.addStringArg(_displayViewModel.ascii);
  _asciiDisplaySender.sendMessage(asciiMessage, false);
  ofLog() << "_asciiDisplaySender.sendMessage() -> to " << _asciiDisplaySender.getHost() << ":" << _asciiDisplaySender.getPort() << " ascii.length() " << _displayViewModel.ascii.length();

  ofxOscMessage faceMessage;
  faceMessage.setAddress("/display/face");
  faceMessage.addInt32Arg(_displayViewModel.uid);
  faceMessage.addStringArg(fakeId);
  faceMessage.addInt32Arg(_displayViewModel.age);
  for(auto & feature : encodedFeatures) {
    faceMessage.addStringArg(feature);
  }
  _faceDisplaySender.sendMessage(faceMessage, false);
  ofLog() << "_faceDisplaySender.sendMessage() -> to " << _faceDisplaySender.getHost() << ":" << _faceDisplaySender.getPort();

  ofxOscMessage genderMessage;
  genderMessage.setAddress("/display/gender");
  genderMessage.addInt32Arg(_displayViewModel.uid);
  genderMessage.addStringArg(fakeId);
  genderMessage.addBoolArg(_displayViewModel.isMale);
  for(auto & feature : encodedFeatures) {
    genderMessage.addStringArg(feature);
  }
  _genderDisplaySender.sendMessage(genderMessage, false);
  ofLog() << "_genderDisplaySender.sendMessage() -> to " << _genderDisplaySender.getHost() << ":" << _genderDisplaySender.getPort();

  ofxOscMessage genderImageMessage;
  genderImageMessage.setAddress("/display/img");
  genderImageMessage.addInt32Arg(_displayViewModel.uid);
  genderImageMessage.addBlobArg(greyscaleBuffer);  
  _genderDisplaySender.sendMessage(genderImageMessage, false);
  ofLog() << "_genderDisplaySender.sendImageMessage() -> to " << _genderDisplaySender.getHost() << ":" << _genderDisplaySender.getPort();

  ofxOscMessage emotionMessage;
  emotionMessage.setAddress("/display/emotion");
  emotionMessage.addInt32Arg(_displayViewModel.uid);
  emotionMessage.addStringArg(fakeId);
  emotionMessage.addStringArg(_displayViewModel.emotion);
  emotionMessage.addStringArg(_displayViewModel.ascii);
  _emotionDisplaySender.sendMessage(emotionMessage, false);
  ofLog() << "_emotionDisplaySender.sendMessage() -> to " << _emotionDisplaySender.getHost() << ":" << _emotionDisplaySender.getPort();

  ofxOscMessage listMessage;
  listMessage.setAddress("/display/list");
  listMessage.addInt32Arg(_displayViewModel.uid);
  listMessage.addStringArg(fakeId);
  _listDisplaySender.sendMessage(listMessage, false);
  ofLog() << "_listDisplaySender.sendMessage() -> to " << _listDisplaySender.getHost() << ":" << _listDisplaySender.getPort();
}

std::string DisplayCommunicator::_encodePolyline(ofPolyline & polyline) {
  std::string polylineBuffer;
  for(auto & vector3 : polyline) {
    polylineBuffer += ofToString(roundf(vector3.x))+","+ofToString(roundf(vector3.y))+",";
  }
  polylineBuffer.pop_back();
  return polylineBuffer;
}

std::string DisplayCommunicator::_generateRandomString(int length) {
  static const char alphanum[] =
        "0123456789"
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        "abcdefghijklmnopqrstuvwxyz";
  std::string retval;
  retval.resize(length);
  for(int i = 0; i < length; i++) {
    retval[i] = alphanum[rand() % (sizeof(alphanum) - 1)];
  }
  return retval;
}