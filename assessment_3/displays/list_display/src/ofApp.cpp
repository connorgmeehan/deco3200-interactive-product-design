#include "ofApp.h"

//--------------------------------------------------------------
void ofApp::setup(){
  std::string host = ofToString(getenv("DISPLAY_HOST"));
  int port = ofToInt(getenv("DISPLAY_PORT"));
  ofLog() << "Hosting ofxOscReceiver on " << host << ":" << port;
  _receiver.setup(port);
  _listDisplay.setup();
}

//--------------------------------------------------------------
void ofApp::update(){
  while(_receiver.hasWaitingMessages()) {
    ofxOscMessage message;
    _receiver.getNextMessage(message);
    ofLog() << "Reciever() -> new message at address: " << message.getAddress();

    if (message.getAddress() == "/display/list") {
      int uid = message.getArgAsInt(0);
      string fakeId = message.getArgAsString(1);
      int age = message.getArgAsInt(2);
      bool isMale = message.getArgAsBool(3);
      string emotion = message.getArgAsString(4);


    }
  }
}

//--------------------------------------------------------------
void ofApp::draw(){
  ofBackground(0);
  _listDisplay.draw();
}

//--------------------------------------------------------------
void ofApp::keyPressed(int key){

}

//--------------------------------------------------------------
void ofApp::keyReleased(int key){

}

//--------------------------------------------------------------
void ofApp::mouseMoved(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseDragged(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mousePressed(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseReleased(int x, int y, int button){

}

//--------------------------------------------------------------
void ofApp::mouseEntered(int x, int y){

}

//--------------------------------------------------------------
void ofApp::mouseExited(int x, int y){

}

//--------------------------------------------------------------
void ofApp::windowResized(int w, int h){

}

//--------------------------------------------------------------
void ofApp::gotMessage(ofMessage msg){

}

//--------------------------------------------------------------
void ofApp::dragEvent(ofDragInfo dragInfo){ 

}