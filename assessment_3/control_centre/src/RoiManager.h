#pragma once

#include "ofMain.h"
#include "ofxCv.h"

#include "ThreadedFaceTracker.h"
#include "AlgorithmCommunicator.h"

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
		AlgorithmCommunicator communicator;

    std::function<void(uint64_t, ofImage&)> sendRoiCallback;
    uint64_t _currentId = 0;  // Stores unique identifier for each user (to remember their face by)
    int _triggerLimit;
    std::vector<ofImage> _rois;
};