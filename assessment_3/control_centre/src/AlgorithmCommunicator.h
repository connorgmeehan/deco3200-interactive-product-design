
#include "ofMain.h"
#include "ofxHTTP.h"

class AlgorithmCommunicator {
	public:
		void setup();
		void update();
		void draw();

		void sendRoi(uint64_t uid, ofImage& rois);
		void clearRois();
		
    std::function<void(uint64_t, ofImage&)> getSendRoiCallback();		
	private:
		bool _executePostRequest(ofx::HTTP::PostRequest& request);
		std::string _baseUri;
};

// TODO: add alert method to server so each algorithm can alert the http server of its function and where it's located and auto configure itself