AsciiDisplay asciiDisplay;

void setup() {
  size(1440, 1024);
  smooth();

  asciiDisplay = new AsciiDisplay();
  asciiDisplay.setup("1234567890123456", loadStrings("face_B.txt"));
}


void draw() {
  asciiDisplay.draw();
}
