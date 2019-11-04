import oscP5.*;

OscP5 oscP5;
AsciiDisplay asciiDisplay;

void setup() {
  size(1440, 1024);
  smooth();

  String host = System.getenv("ASCII_DISPLAY_SERVER_ADDR");
  // String host = "localhost";
  int serverPort = Integer.parseInt(System.getenv("ASCII_DISPLAY_SERVER_PORT"));
  // int serverPort = 8010;
  println("Hosting on " + host + ":" + serverPort);
  oscP5 = new OscP5(this, serverPort);

  asciiDisplay = new AsciiDisplay();
  asciiDisplay.setup("1234567890123456", loadStrings("face_B.txt"));
}


void draw() {
  asciiDisplay.draw();
}

void oscEvent(OscMessage message) {
  print("### received an osc message.");
  print(" addrpattern: "+message.addrPattern());
  println(" typetag: "+message.typetag());
  if(message.addrPattern().equals("/display/ascii")) { //<>//
    int uid = message.get(0).intValue();
    String fakeId = message.get(1).stringValue();
    String ascii = message.get(2).stringValue();
    println("ascii.length" + ascii.length());
    String lines[] = ascii.split("(\r\n|\r|\n)", -1);
    asciiDisplay.setup(fakeId, lines);
  }
}
