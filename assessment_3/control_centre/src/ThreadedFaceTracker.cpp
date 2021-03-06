#include "ThreadedFaceTracker.h"
#include "ProjectDefines.h"

int ThreadedFaceTracker::_padding = 40;
float ThreadedFaceTracker::_maxOrientationDifference = 0.4f;

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

std::vector<ofPolyline> ThreadedFaceTracker::getFaceTrackingFeatures() {
  std::vector<ofPolyline> retval;
  retval.resize(ofxFaceTracker::Feature::ALL_FEATURES);

  for(int featureInt = ofxFaceTracker::Feature::LEFT_EYE_TOP; featureInt < ofxFaceTracker::Feature::ALL_FEATURES; featureInt++) {
    ofxFaceTracker::Feature feature = static_cast<ofxFaceTracker::Feature>(featureInt);
    retval[featureInt] = _tracker.getImageFeature(feature);
  }

  return retval;
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
        cv::Mat greyscaleCvFrame(cvFrame, ofxCv::toCv(_activeRoi));
        payload->greyscale = greyscaleCvFrame.clone();
        cv::cvtColor(payload->greyscale, payload->greyscale, CV_RGB2GRAY);
        cv::resize(payload->greyscale, payload->greyscale, cv::Size(150, 150));
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
  bounds.x = ofClamp(bounds.x - _padding, 0, bounds.x);
  bounds.y = ofClamp(bounds.y - _padding, 0, bounds.y);
  bounds.width = ofClamp(bounds.width + _padding * 2, bounds.width, (_grabber.getWidth() - bounds.x) + bounds.width + _padding * 2);
  bounds.height = ofClamp(bounds.height + _padding * 2, bounds.height, (_grabber.getHeight() - bounds.y) + bounds.height + _padding * 2);

  return bounds;
}

bool ThreadedFaceTracker::_faceOrientedForward(glm::vec3 orientation) {
  return glm::length(orientation) < _maxOrientationDifference;
}