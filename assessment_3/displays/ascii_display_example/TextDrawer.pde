class TextDrawer {
  String[] toDisplay;
  int x, y;
  int lineSpacing;
  color c;
  PFont font;
  float fontSize;
  //String typewrite;

  int counter = 0;

  TextDrawer(String _toDisplay, int _x, int _y, color _c, int _lineSpacing, PFont _font, float _fontSize) {
    toDisplay = loadStrings( _toDisplay);
    x = _x;
    y = _y;
    c = _c;
    lineSpacing = _lineSpacing;
    fontSize = _fontSize;
    font = _font;
  }

  void drawText() {
    int currentY = y;
    for (int i = 0; i < toDisplay.length; i++) {
      if (i < count) {
        fill(c);
        textFont(font, fontSize);
        text("" + toDisplay[i] + "", x, currentY);
      }
      currentY += lineSpacing;
    }
  }


  void typewriter() {
    fill(c);
    textFont(font, fontSize);
    if (counter < toDisplay[0].length() ) { 
      counter++;
      text(toDisplay[0].substring(0, counter), x, y);
    }
  }
}
