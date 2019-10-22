#pragma once

#include "ofMain.h"
#include "ofxOsc.h"

struct DisplayVM {
  DisplayVM() :
    uid(-1),
    age(-1),
    isMale(false),
    ascii("") { }

  bool isReadyToBeSent() {
    return uid != -1 && age != -1 && ascii.length() > 0 && features.size() > 0;
  }

  int uid;
  int age;
  std::vector<ofPolyline> features;
  bool isMale;
  std::string ascii;
};

class DisplayCommunicator {
  public:
    void setup();
    void update();
    void draw();

    void sendDataToDisplays(DisplayVM& viewModel);

  private:

};