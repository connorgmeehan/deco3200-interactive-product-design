#pragma once

#include "ofMain.h"
#include "ofxFaceTracker.h"
#include "utils/Throttler.h"

struct ThreadedFaceTrackerPayload {
  glm::vec2 position;
  glm::vec3 orientation;
  cv::Mat roi;
};

typedef std::function<void(ThreadedFaceTrackerPayload*)> ThreadedFaceTrackerCallback;

class ThreadedFaceTracker {
  public:
    ~ThreadedFaceTracker();
    void setup(int width, int height, float refreshRate);
    void update();
    void draw();
    void stop();

    void setDeliverPayloadCallback(ThreadedFaceTrackerCallback callback);
    void setClearRoiTrackerCallback(std::function<void()> callback);
    void setPadding(int padding);
  private:

    ofRectangle _getBoundingRect(ofxFaceTracker & tracker);
    bool _faceOrientedForward(glm::vec3 orientation);
    
    int _width, _height;
    float _refreshRate;
    int _padding = 10;
    float _maxOrientationDifference = 0.4f;

    ofVideoGrabber _grabber;
    ofxFaceTracker _tracker;
    Throttler _payloadThrottler;

    ofRectangle _activeRoi; // Stores the current position of the face on camera

    ThreadedFaceTrackerCallback _deliverPayloadCallback;
    std::function<void()> _clearRoiTrackerCallback;

};