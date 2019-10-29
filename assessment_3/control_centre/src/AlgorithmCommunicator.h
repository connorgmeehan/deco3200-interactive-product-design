
#include "ofMain.h"

#include "ofxOsc.h"
#include "ofxFifo.h"
#include "ofxFifoThread.h"

#include "DisplayCommunicator.h"

class AlgorithmCommunicator {
	public:
		~AlgorithmCommunicator();
		void setup();
		void update();
		void draw();

		void sendRoi(uint64_t uid, ofImage& rois);
		void clearRois();
		
    std::function<void(uint64_t, ofImage&)> getSendRoiCallback();	
	private:
		void _handleUserDetected(int uid, bool isNew);	
		void _handleUserDemographic(int uid, bool isMale, int age);
		void _handleUserASCII(int uid, std::string& asciiArt);

		ofxFifo::vidWriteThread _fifoWriteThread;

		std::string _host = "127.0.0.1";
		int _recieverPort, _recogniserServerPort, _asciiServerPort, _emotionServerPort, _demographicServerPort;
		ofxOscReceiver _reciever;
		ofxOscSender _recogniserSender;
		ofxOscSender _asciiSender;
		ofxOscSender _emotionSender;
		ofxOscSender _demographicSender;

		int _lastUid, _lastWidth, _lastHeight;
		DisplayVM _displayViewModel;
};

// TODO: add alert method to server so each algorithm can alert the http server of its function and where it's located and auto configure itself