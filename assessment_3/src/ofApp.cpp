#include "ofApp.h"
#include "ofxCv.h"

#define DETECT_BUFFER_SIZE 0x20000

//--------------------------------------------------------------
void ofApp::setup(){
  webcam.setPixelFormat(OF_PIXELS_RGB);
  webcam.setup(INPUT_WIDTH, INPUT_HEIGHT);

  pBuffer = (unsigned char *)malloc(DETECT_BUFFER_SIZE);  
  if(!pBuffer)
  {
      fprintf(stderr, "Can not alloc buffer.\n");
      ofExit(-1);
  }
}

//--------------------------------------------------------------
void ofApp::update(){
  webcam.update();
  if(webcam.isFrameNew()) {
    auto image = ofxCv::toCv(webcam);
    // ofLog() << webcam.getPixelFormat();
    // cv::cvtColor(image, image, CV_RGB2BGR);
    if(!image.empty())
    {
      pResults = facedetect_cnn(pBuffer, (unsigned char*)(image.ptr(0)), image.cols, image.rows, (int)image.step.buf[1]);
    }
  }
}

//--------------------------------------------------------------
void ofApp::draw(){
  ofBackground(ofColor::grey);
  ofSetColor(ofColor::white);
  webcam.draw(0, 0);

  ofSetColor(ofColor::red);
  ofLog() << "pResults: " << (pResults ? *pResults : 0);
  for(int i = 0; i < (pResults ? *pResults : 0); i++)
	{
    short * p = ((short*)(pResults+1))+142*i;
		int x = p[0];
		int y = p[1];
		int w = p[2];
		int h = p[3];
		int confidence = p[4];
		int angle = p[5];

    ofDrawRectangle(x, y, w, h);
    ofDrawBitmapString("confidence: " + ofToString(confidence), w, h - 24);
    ofDrawBitmapString("angle: " + ofToString(angle), w, h - 12);
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
  free(pBuffer);
}