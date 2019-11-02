import oscP5.*;

String host;
int serverPort;

StateManager stateManager;

OscP5 oscP5;

void setup() {
  stateManager = new StateManager();
  //host = System.getenv("GENDER_DISPLAY_SERVER_ADDR");
  //serverPort = Integer.parseInt(System.getenv("GENDER_DISPLAY_SERVER_PORT"));
  host = "localhost";
  serverPort = 8012;
  println("Hosting on " + host + ":" + serverPort);
  size(400,400);
  frameRate(25);
  oscP5 = new OscP5(this, serverPort);
  
  stateManager.addState("STATE 1", 50);
  stateManager.addState("STATE 2", 100);
  stateManager.addState("STATE 3", 150);
  stateManager.addState("STATE 4", 200);
}

void draw() {
  stateManager.incrementFrame();
  println("state: " + stateManager.getState() + " progress: " + stateManager.getProgress());
  println("state 1: " + stateManager.getProgressOfState("STATE 1"));
  background(0);
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage message) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+message.addrPattern());
  println(" typetag: "+message.typetag()); //<>//
  int uid = message.get(0).intValue();
  boolean isMale = message.get(1).booleanValue();
  println("uid: " + uid + ", isMale: " + isMale);
  ArrayList<String> encodedFeatures = new ArrayList<String>();
  for(int i = 0; i < 14; i++) {
    println("feature("+i+")" + message.get(i+2).stringValue());
    encodedFeatures.add(message.get(i+2).stringValue());
  }
}
