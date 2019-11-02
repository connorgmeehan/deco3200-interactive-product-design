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