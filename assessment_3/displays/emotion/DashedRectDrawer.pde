import garciadelcastillo.dashedlines.*;

class DashedRectDrawer {
  DashedLines dash;
  int x, y;
  color c;
  String label;
  
  DashedRectDrawer(DashedLines _dash, int _x, int _y, color _c, String _label) {
    dash = _dash;
    x = _x;
    y = _y;
    c = _c;
    label = _label;
  }

  void draw() {
      fill(#DC3F36);
      text(label, x-50, y+ 75);
        
      noFill();
      strokeWeight(2);
      stroke(c);
      dash.rect(x-4, y-8, 195, 144);
  }
}