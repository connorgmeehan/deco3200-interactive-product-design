#pragma once

#include "ofMain.h"
#include "ofxFaceTracker.h"

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
    void setPadding(int padding);
  private:
    int _width, _height;
    float _refreshRate;
    int _padding = 10;

    ofVideoGrabber _grabber;
    ofxFaceTracker _tracker;

    ofRectangle _activeRoi;

    ThreadedFaceTrackerCallback _deliverPayloadCallback;

    ofRectangle _getBoundingRect(ofxFaceTracker & tracker);
};