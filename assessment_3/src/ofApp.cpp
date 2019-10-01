#include "ofApp.h"
#include "ofxCv.h"

#define DETECT_BUFFER_SIZE 0x20000

//--------------------------------------------------------------
void ofApp::setup(){
  auto trackerCallback = std::bind(&ofApp::handleFaceTrackerPayload, this, std::placeholders::_1);
  tracker.setDeliverPayloadCallback(trackerCallback);  
  tracker.setup(INPUT_WIDTH, INPUT_HEIGHT, .5f);
}

//--------------------------------------------------------------
void ofApp::update(){
  tracker.update();
}

//--------------------------------------------------------------
void ofApp::draw(){
  ofBackground(20);
  tracker.draw();
  
  int offset = 0;
  for(auto & image : images) {
    image.draw(0,offset);
    offset += image.getHeight();
  }
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

void ofApp::handleFaceTrackerPayload(ThreadedFaceTrackerPayload* pPayload) {
  ofLog() << "handleFaceTrackerPayload(payload)";
  ofLog() << "payload.position" << pPayload->position;
  ofLog() << "payload.orientation" << pPayload->orientation;
  
  ofImage temp;
  ofxCv::toOf(pPayload->roi, temp);
  temp.update();
  images.push_back(temp);
}