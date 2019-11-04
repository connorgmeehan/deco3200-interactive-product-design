import oscP5.*;
import garciadelcastillo.dashedlines.*;

OscP5 oscP5;
EmotionDisplay emotionDisplay;
DashedLines dash;

void setup() {
  size(1440, 1024);
  smooth();

  String host = System.getenv("EMOTION_DISPLAY_SERVER_ADDR");
  // String host = "localhost";
  int serverPort = Integer.parseInt(System.getenv("EMOTION_DISPLAY_SERVER_PORT"));
  // int serverPort = 8010;
  println("Hosting on " + host + ":" + serverPort);
  oscP5 = new OscP5(this, serverPort);
  dash = new DashedLines(this);
  dash.pattern(6, 8);


  emotionDisplay = new EmotionDisplay(dash);
  emotionDisplay.setup("1234567890123456", loadStrings("main_face.txt"));
}


void draw() {
  emotionDisplay.draw();
}

void oscEvent(OscMessage message) {
  print("### received an osc message.");
  print(" addrpattern: "+message.addrPattern());
  println(" typetag: "+message.typetag());
  if(message.addrPattern().equals("/display/emotion")) { //<>//
    int uid = message.get(0).intValue();
    String fakeId = message.get(1).stringValue();
    String emotion = message.get(2).stringValue();
    String ascii = message.get(3).stringValue();
    println("ascii.length" + ascii.length());
    String lines[] = ascii.split("(\r\n|\r|\n)", -1);
    emotionDisplay.setup(fakeId, lines);
  }
}
