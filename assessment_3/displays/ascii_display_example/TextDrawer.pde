class TextDrawer {
  String[] toDisplay;
  int fontSize;
  int x, y;
  int lineSpacing;
  color c;
  PFont font;
  
  TextDrawer(String file, int _fontSize, int xPos, int yPos, color col, int inc, PFont pf) {
    toDisplay = loadStrings("" + file + ".txt");
    fontSize = _fontSize;
    x = xPos;
    y = yPos;
    c = col;
    lineSpacing = inc;
    font = pf; 
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
}
