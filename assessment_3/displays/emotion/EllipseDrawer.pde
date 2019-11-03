class EllipseDrawer {
  int x, y;
  color c;
  String label;
  boolean drawAbove;
  
  
  EllipseDrawer(int _x, int _y, color _c, String _label, boolean _drawAbove) {
    x = _x;
    y = _y;
    c = _c;
    label = _label;
    drawAbove = _drawAbove;
    
  }

  void draw() {
    // void draw(float progress) {
    // int progressIndex = int(float(toDisplay.length) * progress);
    fill(#DC3F36);
    textFont(font, 10);
    if (drawAbove) {
        text(label, x, y-50);
    } else {
        text(label, x, y+50);
    }
    // for (int i = 0; i < 1; i++) {
      noFill();
      stroke(c);
      dash.ellipse(x, y, 50, 50);
    // }
  }
}