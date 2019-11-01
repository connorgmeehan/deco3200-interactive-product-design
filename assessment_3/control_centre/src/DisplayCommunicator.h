#pragma once

#include "ofMain.h"
#include "ofxOsc.h"

#include "DisplayVM.h"

class DisplayCommunicator {
  public:
    void setup();
    void update();
    void draw();

    void sendModelToDisplays(DisplayVM& viewModel);

  private:
    std::string _oscTestAddr;
    int _oscTestPort;
    ofxOscSender _oscTestSender;
};