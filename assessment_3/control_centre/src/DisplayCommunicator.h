#pragma once

#include "ofMain.h"
#include "ofxOsc.h"

#include "DisplayVM.h"

class DisplayCommunicator {
  public:
    void setup();
    void update();
    void draw();

    void handleUserDetected(int uid, bool isNew, std::vector<ofPolyline> lines, ofImage& greyscale);	
		void handleUserDemographic(int uid, int age, bool isMale);
		void handleUserEmotion(int uid, std::string emotion);
		void handleUserASCII(int uid, std::string& asciiArt);
  private:
    bool _checkIfNewUid(int uid);
		void _trySendModelToDisplays();
    void _sendModel(DisplayVM& viewModel);
    std::string _encodePolyline(ofPolyline & polyline);
    std::string _generateRandomString(int length);

		DisplayVM _displayViewModel;

    ofxOscSender _oscTestSender, _asciiDisplaySender, _faceDisplaySender, _genderDisplaySender, _emotionDisplaySender, _listDisplaySender;

    ofImage lastGreyscale;
};