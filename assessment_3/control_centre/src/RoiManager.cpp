#include "RoiManager.h"

void RoiManager::setup(int triggerLimit) {
  communicator.setup();
  _triggerLimit = triggerLimit;
}

void RoiManager::update() {
  if(rois.size() > _triggerLimit) {
    communicator.sendRois(_currentId, rois);
    clear();
  }
}

void RoiManager::draw() {
  int xoffset = 0;
  int yoffset = 0;
  for(auto & image : rois) {
    image.draw(xoffset, yoffset);
    yoffset += image.getHeight();
    if(yoffset + image.getHeight() > ofGetHeight()) {
      xoffset += image.getWidth();
      yoffset = 0;
    }
  }
}

void RoiManager::handleFaceTrackerPayload(ThreadedFaceTrackerPayload* pPayload) {
  ofLog() << "handleFaceTrackerPayload(payload)";
  ofLog() << "payload.position" << pPayload->position;
  ofLog() << "payload.orientation" << pPayload->orientation;
  
  ofImage temp;
  ofxCv::toOf(pPayload->roi, temp);
  temp.update();
  rois.push_back(temp);
}

void RoiManager::clear() {
  _currentId++; // update ID so each batch of images has a unique identifier
  rois.clear();
}

ThreadedFaceTrackerCallback RoiManager::getFaceTrackerCallback() {
  return std::bind(&RoiManager::handleFaceTrackerPayload, this, std::placeholders::_1);
}

std::function<void()> RoiManager::getClearRoiCallback() {
  return std::bind(&RoiManager::clear, this);
}