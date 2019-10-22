import netP5.*; 
import oscP5.*;

OscP5 osc;
NetAddress address;
void setup() {
	osc = new OscP5(this, servePort);
	address = new NetAddress(serveAddress, servePort);
}

void update() {
	
}

void oscEvent(OscMessage message) {
        if(message.checkAddrPatter("/display/ascii") == true) {
            if(message.checkTypetag("is")) {
                int uid = message.get(0).intValue();
                String ascii = message.get(1).stringValue();

                print("### received an osc message /display/ascii with typetag is.");
                print("### uid: " + uid + ", ascii: \n" + ascii + "\n);");
            }
        }
    }
