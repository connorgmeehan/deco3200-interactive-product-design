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
    fill(#DC3F36);
    textFont(font2, 16);
    if (drawAbove) {
        text(label, x, y-40);
    } else {
        text(label, x, y+50);
    }
      noFill();
      strokeWeight(4);
      stroke(c);
      dash.ellipse(x, y, 30, 30);
  }
}