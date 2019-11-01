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

    void handleUserDetected(int uid, bool isNew);	
		void handleUserDemographic(int uid, int age, bool isMale);
		void handleUserEmotion(int uid, std::string emotion);
		void handleUserASCII(int uid, std::string& asciiArt);
		void trySendModelToDisplays();
  private:

    std::string _oscTestAddr;
    int _oscTestPort;
    ofxOscSender _oscTestSender;
};