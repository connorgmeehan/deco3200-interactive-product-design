class GetFaceSegment {

  String[] toDisplay;
  float iter;              //0, 0.25, 0.5, 0.75
  float range;             // 0.25, 0.5, 0.75, 1            
  float startSub;          //0, 0.5, 1
  float endSub;            //0, 0.5, 1
  int x, y;

  GetFaceSegment(String _toDisplay, float _iter, float _range, float _startSub, float _endSub) {
    toDisplay = loadStrings(_toDisplay);
    iter = _iter;
    range = _range;
    startSub = _startSub;
    endSub = _endSub;
    x = 100;
    y = 0;
  }

  void draw() {
    fill(255);
    textFont(font, 4);
    int y = 0;
    for (int i = int((toDisplay.length)*iter); i < toDisplay.length*range; i++) {
      if (i < count) {
        text(toDisplay[i].substring(int((toDisplay[i].length())*startSub), int(toDisplay[i].length()*endSub)), x, y);
      }
      y += 6;
    }
    count++;
  }
}
