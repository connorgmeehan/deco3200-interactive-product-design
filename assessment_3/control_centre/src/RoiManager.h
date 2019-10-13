#pragma once

#include "ofMain.h"
#include "ofxCv.h"

#include "ThreadedFaceTracker.h"

class RoiManager {
  public:
    void setup(int triggerLimit);
    void update();
    void draw();
    
    void clear();

		void handleFaceTrackerPayload(ThreadedFaceTrackerPayload * pPayload);
    ThreadedFaceTrackerCallback getFaceTrackerCallback();
    std::function<void()> getClearRoiCallback();
  private:
    uint64_t _currentId = 0;  // Stores unique identifier for each user (to remember their face by)
    int _triggerLimit;
    std::vector<ofImage> rois;
};