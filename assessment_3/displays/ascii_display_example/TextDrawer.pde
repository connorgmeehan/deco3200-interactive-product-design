class TextDrawer {
  String[] toDisplay;
  int x, y;
  int lineSpacing;
  color c;
  PFont font;
  float fontSize;
  //String typewrite;
  color secondColor = color(255, 255);

  TextDrawer(String _toDisplay, int _x, int _y, color _c, int _lineSpacing, PFont _font, float _fontSize) {
    toDisplay = loadStrings( _toDisplay);
    x = _x;
    y = _y;
    c = _c;
    lineSpacing = _lineSpacing;
    fontSize = _fontSize;
    font = _font;
  }

  void setSecondColor(color _color) {
    secondColor = _color;
  }

  void drawTextByLine(float progress) {
    int progressIndex = int(float(toDisplay.length) * progress);
    fill(c);
    textFont(font, fontSize);
    for (int i = 0; i < progressIndex; i++) {
      text("" + toDisplay[i] + "", x, y + i * lineSpacing);
    }
  }
}
