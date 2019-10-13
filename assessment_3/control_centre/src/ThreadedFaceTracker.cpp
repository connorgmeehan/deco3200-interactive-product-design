#include "ThreadedFaceTracker.h"
#include "ProjectDefines.h"

ThreadedFaceTracker::~ThreadedFaceTracker() {
}

void ThreadedFaceTracker::setup(int width, int height, float refreshRate) {
  _grabber.setup(width, height);
  _tracker.setup();
  _tracker.setRescale(1.0f);

  _payloadThrottler = Throttler(refreshRate);
}

void ThreadedFaceTracker::setDeliverPayloadCallback(ThreadedFaceTrackerCallback cb) {
  _deliverPayloadCallback = cb;
}

void ThreadedFaceTracker::setClearRoiTrackerCallback(std::function<void()> cb) {
  _clearRoiTrackerCallback = cb;
}

void ThreadedFaceTracker::setPadding(int padding) {
  _padding = padding;
}

void ThreadedFaceTracker::update() {
  _grabber.update();
  if (_grabber.isFrameNew()) {
    auto cvFrame = ofxCv::toCv(_grabber);
    _tracker.update(cvFrame);

    if(_tracker.getFound() && _faceOrientedForward(_tracker.getOrientation())) {
      // Get bounding box from face object points
      _activeRoi = _getBoundingRect(_tracker);
      // ofLog() << "Mask discovered: x: " << mask.tl().x << " y: " << mask.tl().y << " x+w: " << mask.br().x << " y+h: "<<  mask.br().y; 
      // Crop cvFrame to get cutout roi
      if(0 <= _activeRoi.x 
        && 0 <= _activeRoi.width
        && _activeRoi.x + _activeRoi.width <= INPUT_WIDTH
        && 0 <= _activeRoi.y && 0 <= _activeRoi.height
        && _activeRoi.y + _activeRoi.height <= INPUT_HEIGHT) {
        
        auto payload = new ThreadedFaceTrackerPayload();
        cvFrame(ofxCv::toCv(_activeRoi)).copyTo(payload->roi);
        payload->position = _tracker.getPosition();
        payload->orientation = _tracker.getOrientation();

        if(_payloadThrottler.check()) {
          // lock();
          _deliverPayloadCallback(payload);
          // unlock();
        }
      }     
    } else {
      _clearRoiTrackerCallback();
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

bool ThreadedFaceTracker::_faceOrientedForward(glm::vec3 orientation) {
  ofLog() << "glm::length " << glm::length(orientation);
  return glm::length(orientation) < _maxOrientationDifference;
}