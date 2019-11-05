import oscP5.*;

String host;
int serverPort;

OscP5 oscP5;

ListDisplay listDisplay;

void setup() {
    size(1024, 768);
    host = System.getenv("LIST_DISPLAY_SERVER_ADDR");
    serverPort = Integer.parseInt(System.getenv("LIST_DISPLAY_SERVER_PORT"));
    println("Hosting on " + host + ":" + serverPort);
    oscP5 = new OscP5(this, serverPort);

    listDisplay = new ListDisplay();
}

void draw() {
    background(0);

    tempCount++;
    if(tempCount > 50) {
        listDisplay.setup();
    }

    listDisplay.draw();
}

int tempCount = 0;
void oscEvent(OscMessage message) {
    /* print the address pattern and the typetag of the received OscMessage */
    print("### received an osc message.");
    print(" addrpattern: "+message.addrPattern()); //<>//
    println(" typetag: "+message.typetag());
    if(message.addrPattern().equals("/display/list")) {
        int uid = message.get(0).intValue();
        String fakeId = message.get(1).stringValue();
        // listDisplay.setup(uid, fakeId);
    }    
}