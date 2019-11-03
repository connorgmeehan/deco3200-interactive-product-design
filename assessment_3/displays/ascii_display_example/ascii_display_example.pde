AsciiDisplay asciiDisplay;

void setup() {
  size(1440, 1024);
  smooth();

  asciiDisplay = new AsciiDisplay();
}


void draw() {
  asciiDisplay.draw();
}
