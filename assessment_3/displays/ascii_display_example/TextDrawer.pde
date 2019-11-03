class TextDrawer {
  final int typewriteSpeed = 1000;
  
  String[] toDisplay;
  int x, y;
  int lineSpacing;
  color c;
  PFont font;
  float fontSize;
  //String typewrite;
  color caretColor = color(255, 255);

  TextDrawer(List<String> _toDisplay, int _x, int _y, color _c, int _lineSpacing, PFont _font, float _fontSize) {
    String[] toDisplayArray = new String[_toDisplay.size()];
    toDisplay = _toDisplay.toArray(toDisplayArray);
    x = _x;
    y = _y;
    c = _c;
    lineSpacing = _lineSpacing;
    fontSize = _fontSize;
    font = _font;  }

  TextDrawer(String[] _toDisplay, int _x, int _y, color _c, int _lineSpacing, PFont _font, float _fontSize) {
    toDisplay = _toDisplay;
    x = _x;
    y = _y;
    c = _c;
    lineSpacing = _lineSpacing;
    fontSize = _fontSize;
    font = _font;
  }

  void setCaretColor(color _color) {
    caretColor = _color;
  }

  void drawTextByLine(float progress) {
    int progressIndex = int(float(toDisplay.length) * progress);
    fill(c);
    textFont(font, fontSize);
    for (int i = 0; i < progressIndex; i++) {
      text("" + toDisplay[i] + "", x, y + i * lineSpacing);
    }
  }

  void drawTextByChar(float progress) {
    drawTextByChar(progress, false);
  }

  void drawTextByChar(float progress, boolean shouldTypewriterEnd) {
    int progressIndex = int(float(toDisplay[0].length()) * progress);
    String toDraw = toDisplay[0].substring(0, progressIndex);
    fill(caretColor);
    if(shouldTypewriterEnd
     && ((progress > 0.01 && progress < 0.99)
     || (millis() % typewriteSpeed) < (typewriteSpeed / 2))) {
      float blockX = toDraw.length() * fontSize * 0.61 + 2;
      rect(x + blockX, y - fontSize + 2, fontSize * 0.61, fontSize);
    }
    fill(c);
    textFont(font, fontSize);
    text(toDraw, x, y);
  }
}
