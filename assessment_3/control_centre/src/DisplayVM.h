#pragma once

#include "ofMain.h"

enum DetectedState {
  UNKNOWN,
  NEW,
  OLD,
};

struct DisplayVM {
  DisplayVM(int uid = -1) :
    uid(uid),
    age(-1),
    isMale(false),
    ascii(""),
    emotion(""),
    detectedState(DetectedState::UNKNOWN) { }

  bool isReadyToBeSent() {
    bool isReady = uid != -1
      && age != -1
      && ascii.length() > 0
      && features.size() > 0
      && emotion.length() > 0
      && detectedState != DetectedState::UNKNOWN
      && greyscale.getHeight() > 0;

    // bool isReady = ascii.length() > 0;

    ofLog() << "isReadyToBeSend() " << std::endl
      << "\tage: " << age << std::endl
      << "\tascii.length(): " << ascii.length() << std::endl
      << "\tfeatures.size(): " << features.size() << std::endl
      << "\temotion.length(): " << emotion.length() << std::endl
      << "\tdetectedState: " << (detectedState == DetectedState::UNKNOWN ? "UNKOWN"
        : detectedState == DetectedState::NEW ? "NEW" : "OLD") << std::endl
      << "\tisReady: " << ofToString(isReady);
    return isReady;
  }

  DetectedState detectedState;
  int uid;
  int age;
  std::vector<ofPolyline> features;
  bool isMale;
  std::string ascii;
  std::string emotion;
  ofImage greyscale;
};