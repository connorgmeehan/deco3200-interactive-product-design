import java.io.DataInputStream;
import java.io.ByteArrayInputStream;

import oscP5.*;

String host;
int serverPort;

GenderDisplay genderDisplay;

OscP5 oscP5;

void setup() {
  size(400,400);
  genderDisplay = new GenderDisplay();
  genderDisplay.setup(20, "SAD", new ArrayList<ArrayList<PVector>>());
  //host = System.getenv("GENDER_DISPLAY_SERVER_ADDR");
  //serverPort = Integer.parseInt(System.getenv("GENDER_DISPLAY_SERVER_PORT"));
  host = "localhost";
  serverPort = 8012;
  println("Hosting on " + host + ":" + serverPort);
  frameRate(25);
  oscP5 = new OscP5(this, serverPort);
}

void draw() {
  background(0);
  genderDisplay.draw();
}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage message) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+message.addrPattern());
  println(" typetag: "+message.typetag());

  int uid = message.get(0).intValue();
  println(" uid: "+uid);
  boolean isMale = message.typetag().charAt(1) == 'T';

  ArrayList<ArrayList<PVector>> points = new ArrayList<ArrayList<PVector>>();
  for(int i = 0; i < 14; i++) {
    String blob = message.get(i+2).stringValue();
    points.add(new ArrayList<PVector>()); //<>//
    String[] items = blob.split("\\s*,\\s*");
    for(int j = 0; j < items.length; j+=2) {
      PVector vec = new PVector(Integer.parseInt(items[j]), Integer.parseInt(items[j+1])); //<>//
      points.get(i).add(vec); //<>//
    }
  }
  genderDisplay.setup(uid, isMale, points);
}
