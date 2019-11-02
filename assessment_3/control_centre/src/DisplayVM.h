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
    ofLog() << "isReadyToBeSend() " << std::endl
      << "age: " << age << std::endl
      << "ascii.length(): " << ascii.length() << std::endl
      << "features.size(): " << features.size() << std::endl
      << "emotion.length(): " << emotion.length() << std::endl
      << "detectedState: " << (detectedState == DetectedState::UNKNOWN ? "UNKOWN"
        : detectedState == DetectedState::NEW ? "NEW" : "OLD");
    return uid != -1
      && age != -1
      && ascii.length() > 0
      && features.size() > 0
      && emotion.length() > 0
      && detectedState != DetectedState::UNKNOWN;
  }

  DetectedState detectedState;
  int uid;
  int age;
  std::vector<ofPolyline> features;
  bool isMale;
  std::string ascii;
  std::string emotion;
};