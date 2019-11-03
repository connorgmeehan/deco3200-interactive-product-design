class TextDrawer {
  String[] toDisplay;
  int x, y;
  int lineSpacing;
  color c;
  PFont font;
  float fontSize;
  String label;
  boolean drawLeft;
  
  TextDrawer(String _toDisplay, int _x, int _y, color _c, int _lineSpacing, PFont _font, float _fontSize) {
    toDisplay = loadStrings( _toDisplay);
    x = _x;
    y = _y;
    c = _c;
    lineSpacing = _lineSpacing;
    fontSize = _fontSize;
    font = _font;
    label = _label;
    drawLeft = _drawLeft;
  }

  void drawTextByLine(float progress) {
    int progressIndex = int(float(toDisplay.length) * progress);
    fill(c);
    // textFont(font, 18);
    //  if (drawLeft) {
    //   text(label, x-50, y);
    // } else {
    //   text(label, x+50, y);
    // }
    
    textFont(font, fontSize);
    for (int i = 0; i < progressIndex; i++) {
      text("" + toDisplay[i] + "", x, y + i * lineSpacing);
    }
  }
}
