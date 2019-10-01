#include "ofApp.h"
#include "ofxCv.h"

#define DETECT_BUFFER_SIZE 0x20000

//--------------------------------------------------------------
void ofApp::setup(){
  webcam.setPixelFormat(OF_PIXELS_RGB);
  webcam.setup(INPUT_WIDTH, INPUT_HEIGHT);
}

//--------------------------------------------------------------
void ofApp::update(){
  webcam.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
  ofBackground(ofColor::grey);
  ofSetColor(ofColor::white);
  webcam.draw(0, 0);
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

void ofApp::exit() {
}