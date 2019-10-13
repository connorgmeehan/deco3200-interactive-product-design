
#include "ofMain.h"
#include "ofxJSONRPC.h"

class AlgorithmCommunicator {
	public:
		void setup();
		void update();
		void draw();

		void sendRois(uint64_t uid, std::vector<ofImage>& rois);
		
    std::function<void(uint64_t, std::vector<ofImage>&)> getSendRoisCallback();		
	private:
		ofx::HTTP::JSONRPCServer server;
}

// TODO: add alert method to server so each algorithm can alert the http server of its function and where it's located and auto configure itself