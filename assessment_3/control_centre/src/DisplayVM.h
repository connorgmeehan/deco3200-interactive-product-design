#pragma once

#include "ofMain.h"

struct DisplayVM {
  DisplayVM() :
    uid(-1),
    age(-1),
    isMale(false),
    ascii(""),
    emotion("") { }

  bool isReadyToBeSent() {
    return uid != -1 && age != -1 && ascii.length() > 0 && features.size() > 0 && emotion.length() > 0;
  }

  int uid;
  int age;
  std::vector<ofPolyline> features;
  bool isMale;
  std::string ascii;
  std::string emotion;
};