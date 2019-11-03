
import oscP5.*;


String host = Integer.parseInt(System.getenv("OSC_TEST_SERVER_ADDR"));
int serverPort = Integer.parseInt(System.getenv("OSC_TEST_SERVER_PORT"));

OscP5 oscP5;

void setup() {
  size(1024,768);
  frameRate(25);
  oscP5 = new OscP5(this, serverPort);
}

void draw() {
  background(0);
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
