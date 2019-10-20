
#include "ofMain.h"

#include "ofxOsc.h"
#include "ofxFifo.h"
#include "ofxFifoThread.h"

class AlgorithmCommunicator {
	public:
		~AlgorithmCommunicator();
		void setup();
		void update();
		void draw();

		void sendRoi(uint64_t uid, ofImage& rois);
		void clearRois();
		
    std::function<void(uint64_t, ofImage&)> getSendRoiCallback();	

		void handleUserDetected(int uid, bool isNew);	
	private:
		ofxFifo::vidWriteThread _fifoWriteThread;

		std::string _host = "127.0.0.1";
		int _recieverPort, _recogniserServerPort, _asciiServerPort;
		ofxOscReceiver _reciever;
		ofxOscSender _recogniserSender;
		ofxOscSender _asciiSender;

		int _lastWidth, _lastHeight;

};

// TODO: add alert method to server so each algorithm can alert the http server of its function and where it's located and auto configure itself