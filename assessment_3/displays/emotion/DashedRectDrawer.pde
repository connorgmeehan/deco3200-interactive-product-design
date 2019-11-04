class DashedRectDrawer {
  int x, y;
  color c;
  String label;
  
  
  DashedRectDrawer(int _x, int _y, color _c, String _label) {
    x = _x;
    y = _y;
    c = _c;
    label = _label;
    
  }

  void draw() {
      fill(#DC3F36);
      textFont(font2, 22);
      text(label, x-50, y+ 75);
        
      noFill();
      strokeWeight(2);
      stroke(c);
      dash.rect(x-4, y-8, 195, 144);
  }
}