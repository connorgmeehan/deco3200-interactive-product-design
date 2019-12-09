#pragma once

#include "ofMain.h"

#include "ofxOsc.h"
#include "ofxFifo.h"
#include "ofxFifoThread.h"

#include "DisplayCommunicator.h"

class AlgorithmCommunicator {
	public:
		~AlgorithmCommunicator();
		void setup(DisplayCommunicator* pDisplayCommunicator);
		void update();
		void draw();

		void sendRoi(uint64_t uid, ofImage& roi, ofImage& greyscale);
		void clearRois();
		
		void setFaceTrackingFeaturesGetter(std::function<std::vector<ofPolyline>()> getter);
	private:
		std::function<std::vector<ofPolyline>()> _getFaceTrackingFeatures;
		DisplayCommunicator* _pDisplayCommunicator;
		void _handleUserDetected(int uid, bool isNew);	
		void _handleUserDemographic(int uid, int age, bool isMale);
		void _handleUserEmotion(int uid, std::string emotion);
		void _handleUserASCII(int uid, std::string& asciiArt);
		void _trySendModelToDisplays();

		ofxFifo::vidWriteThread _fifoWriteThread;

		std::string _host = "127.0.0.1";
		int _recieverPort, _recogniserServerPort, _asciiServerPort, _emotionServerPort, _demographicServerPort;
		ofxOscReceiver _reciever;
		ofxOscSender _recogniserSender;
		ofxOscSender _asciiSender;
		ofxOscSender _emotionSender;
		ofxOscSender _demographicSender;

		float _userDetectInterval = 5.0f;
		float _nextDetectTrigger;
		int _lastUid, _lastWidth, _lastHeight;
		ofImage _lastGreyscale;
};

// TODO: add alert method to server so each algorithm can alert the http server of its function and where it's located and auto configure itself