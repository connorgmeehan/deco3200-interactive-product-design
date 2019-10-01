#include "ThreadedFaceTracker.h"

ThreadedFaceTracker::~ThreadedFaceTracker() {
}

void ThreadedFaceTracker::setup(int width, int height, float refreshRate) {
  _grabber.setup(width, height);
  _tracker.setup();
  _tracker.setRescale(.5);
}

void ThreadedFaceTracker::setDeliverPayloadCallback(ThreadedFaceTrackerCallback cb) {
  _deliverPayloadCallback = cb;
}

void ThreadedFaceTracker::setPadding(int padding) {
  _padding = padding;
}

void ThreadedFaceTracker::update() {
  _grabber.update();
  if (_grabber.isFrameNew()) {
    auto cvFrame = ofxCv::toCv(_grabber);
    _tracker.update(cvFrame);

    if(_tracker.getFound()) {
      auto payload = new ThreadedFaceTrackerPayload();
      payload->position = _tracker.getPosition();
      payload->orientation = _tracker.getOrientation();
      // Get bounding box from face object points
      _activeRoi = _getBoundingRect(_tracker);
      // ofLog() << "Mask discovered: x: " << mask.tl().x << " y: " << mask.tl().y << " x+w: " << mask.br().x << " y+h: "<<  mask.br().y; 
      // Crop cvFrame to get cutout roi
      // cvFrame(mask).copyTo(payload->roi);

      // lock();
      // _deliverPayloadCallback(payload);
      // unlock();
    }      
  }
}

void ThreadedFaceTracker::draw() {
  ofFill();
  ofSetColor(ofColor::white);
  
  _grabber.draw(0,0);
  _tracker.draw();
  ofNoFill();
  ofDrawRectangle(_activeRoi);

}

void ThreadedFaceTracker::stop() {
 
}

ofRectangle ThreadedFaceTracker::_getBoundingRect(ofxFaceTracker & tracker) {
  auto points = tracker.getImagePoints();
  ofRectangle bounds;
  bounds.set(points[0], 0, 0);
  for(int i = 1; i < points.size(); i++) {
    bounds.growToInclude(points[i]);
  }
  bounds.x -= _padding;
  bounds.y -= _padding;
  bounds.setSize(bounds.width + _padding*2, bounds.height + _padding * 2);
  return bounds;
}