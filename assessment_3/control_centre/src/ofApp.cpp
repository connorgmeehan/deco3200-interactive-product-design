#include "ofApp.h"
#include "ofxCv.h"

#define DETECT_BUFFER_SIZE 0x20000

//--------------------------------------------------------------
void ofApp::setup(){
  roiManager.setup(3);
  
  tracker.setClearRoiTrackerCallback(roiManager.getClearRoiCallback());
  tracker.setDeliverPayloadCallback(roiManager.getFaceTrackerCallback());  
  tracker.setup(INPUT_WIDTH, INPUT_HEIGHT, 3.0f);
  
}

//--------------------------------------------------------------
void ofApp::update(){
  tracker.update();
  roiManager.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
  ofBackground(20);
  tracker.draw();
  roiManager.draw();
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
  tracker.stop();
}