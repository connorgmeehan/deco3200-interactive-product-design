import java.util.Arrays;

int count = 0;
String f = "main_face.txt";
PFont font;

int facesNum = 8;
TextDrawer[] faces = new TextDrawer[facesNum];


void setup() {
  background(0);
  size(1440, 1024);
  strokeWeight(0);
  frameRate(15);
  font = loadFont("Menlo-Regular-5.vlw");

  // top left (0,0)
  String[] faces0Strings = getStringSegment(f, 0, 0.25, 0, 0.5);
  faces[0] = new TextDrawer(faces0Strings, 100, 75, 255, 6, font, 4);

  // top right (0,1)
  String[] faces1Strings = getStringSegment(f, 0, 0.25, 0.5, 1);
  faces[1] = new TextDrawer(faces1Strings, 100, 250, 255, 6, font, 4);

  // top mid left (1,0)
  String[] faces2Strings = getStringSegment(f, 0.25, 0.5, 0, 0.5);
  faces[2] = new TextDrawer(faces2Strings, 100, 425, 255, 6, font, 4);

  // top mid right (1,1)
  String[] faces3Strings = getStringSegment(f, 0.25, 0.5, 0.5, 1);
  faces[3] = new TextDrawer(faces3Strings, 100, 600, 255, 6, font, 4);

  // bottom mid left (2,0)
  String[] faces4Strings = getStringSegment(f, 0.5, 0.75, 0, 0.5);
  faces[4] = new TextDrawer(faces4Strings, 400, 75, 255, 6, font, 4);

  //bottom mid right (2,1)
  String[] faces5Strings = getStringSegment(f, 0.5, 0.75, 0.5, 1);
  faces[5] = new TextDrawer(faces5Strings, 400, 250, 255, 6, font, 4);

  // bottom left (3,0)
  String[] faces6Strings = getStringSegment(f, 0.75, 1, 0, 0.5);
  faces[6] = new TextDrawer(faces6Strings, 400, 425, 255, 6, font, 4);

  // bottom right (3,1)
  String[] faces7Strings = getStringSegment(f, 0.75, 1, 0.5, 1);
  faces[7] = new TextDrawer(faces7Strings, 400, 600, 255, 6, font, 4);
}

void draw() {
  count++;
  for (int i = 0; i < faces.length; i++) {
    faces[i].drawTextByLine(1.0f);
  }
}

String[] getStringSegment(String _toSegment, float _iter, float _range, float _startSub, float _endSub) {    
  String[] toSegment = loadStrings(_toSegment);

  ArrayList<String> returnValue = new ArrayList<String>();
  for (int i = int((toSegment.length)*_iter); i < toSegment.length*_range; i++) {
    returnValue.add( toSegment[i].substring(int((toSegment[i].length())*_startSub), int(toSegment[i].length()*_endSub)));
  }

  String[] arrayList = new String[returnValue.size()];
  for (int j = 0; j < returnValue.size(); j++) { 
    // Assign each value to String array 
    arrayList[j] = returnValue.get(j);
  } 

  return arrayList;
}
