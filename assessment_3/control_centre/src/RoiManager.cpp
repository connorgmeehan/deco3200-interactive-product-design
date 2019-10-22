#include "RoiManager.h"

void RoiManager::setup(int triggerLimit) {
  communicator.setup();
  _triggerLimit = triggerLimit;
}

void RoiManager::update() {
  communicator.update();
  if(_rois.size() > _triggerLimit) {
    clear();
  }
}

void RoiManager::draw() {
  int xoffset = 0;
  int yoffset = 0;
  for(auto & image : _rois) {
    image.draw(xoffset, yoffset);
    yoffset += image.getHeight();
    if(yoffset + image.getHeight() > ofGetHeight()) {
      xoffset += image.getWidth();
      yoffset = 0;
    }
  }
  ofDrawBitmapString("uid: " + ofToString(_currentId), 3, 12);
}

void RoiManager::handleFaceTrackerPayload(ThreadedFaceTrackerPayload* pPayload) {
  ofImage temp;
  ofxCv::toOf(pPayload->roi, temp);
  temp.update();
  _rois.push_back(temp);
  communicator.sendRoi(_currentId, temp);
}

void RoiManager::clear() {
  if(_rois.size() > 0) {
    communicator.clearRois();
    _currentId++; // update ID so each batch of images has a unique identifier
  }
  _rois.clear();
}

ThreadedFaceTrackerCallback RoiManager::getFaceTrackerCallback() {
  return std::bind(&RoiManager::handleFaceTrackerPayload, this, std::placeholders::_1);
}

std::function<void()> RoiManager::getClearRoiCallback() {
  return std::bind(&RoiManager::clear, this);
}