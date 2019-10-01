#include "RoiManager.h"

void RoiManager::setup(int triggerLimit) {
  _triggerLimit = triggerLimit;
}

void RoiManager::update() {
  if(rois.size() > _triggerLimit) {
    // send to algorithms
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
    rois.clear();
}

ThreadedFaceTrackerCallback RoiManager::getFaceTrackerCallback() {
  return std::bind(&RoiManager::handleFaceTrackerPayload, this, std::placeholders::_1);
}

std::function<void()> RoiManager::getClearRoiCallback() {
  return std::bind(&RoiManager::clear, this);
}