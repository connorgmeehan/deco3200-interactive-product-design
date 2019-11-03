import java.util.Arrays;
import garciadelcastillo.dashedlines.*;


int count = 0;
String f = "main_face.txt";
PFont font;

TextDrawer faces0, faces1, faces2, faces3, faces4, faces5, faces6, faces7;
StateManager stateManager;
DashedLines dash;
EllipseDrawer circle;


float dist = 0;
color BLUE = #0029F3;


void setup() {
  background(0);
  size(1440, 1024);
  strokeWeight(0);
  frameRate(15);
  font = loadFont("Menlo-Regular-5.vlw");


  dash = new DashedLines(this);
  dash.pattern(10, 8);

  circle = new EllipseDrawer(600, 300, BLUE, "P1", true);

  stateManager = new StateManager();
  stateManager.addState("FACE_0_PROGRESS", 0);
  stateManager.addState("FACE_1_PROGRESS", 10);
  stateManager.addState("FACE_2_PROGRESS", 20);
  stateManager.addState("FACE_3_PROGRESS", 30);
  stateManager.addState("FACE_4_PROGRESS", 40);
  stateManager.addState("FACE_5_PROGRESS", 50);
  stateManager.addState("FACE_6_PROGRESS", 60);
  stateManager.addState("FACE_7_PROGRESS", 70);
  stateManager.addState("END", 80);

  // top left (0,0)
  String[] faces0Strings = getStringSegment(f, 0, 0.25, 0, 0.5);
  faces0 = new TextDrawer(faces0Strings, 900, 75, 255, 6, font, 4);

  // top right (0,1)
  String[] faces1Strings = getStringSegment(f, 0, 0.25, 0.5, 1);
  faces1 = new TextDrawer(faces1Strings, 900, 250, 255, 6, font, 4);

  // top mid left (1,0)
  String[] faces2Strings = getStringSegment(f, 0.25, 0.5, 0, 0.5);
  faces2 = new TextDrawer(faces2Strings, 900, 425, 255, 6, font, 4);

  // top mid right (1,1)
  String[] faces3Strings = getStringSegment(f, 0.25, 0.5, 0.5, 1);
  faces3 = new TextDrawer(faces3Strings, 900, 600, 255, 6, font, 4);

  // bottom mid left (2,0)
  String[] faces4Strings = getStringSegment(f, 0.5, 0.75, 0, 0.5);
  faces4 = new TextDrawer(faces4Strings, 1200, 75, 255, 6, font, 4);

  //bottom mid right (2,1)
  String[] faces5Strings = getStringSegment(f, 0.5, 0.75, 0.5, 1);
  faces5 = new TextDrawer(faces5Strings, 1200, 250, 255, 6, font, 4);

  // bottom left (3,0)
  String[] faces6Strings = getStringSegment(f, 0.75, 1, 0, 0.5);
  faces6 = new TextDrawer(faces6Strings, 1200, 425, 255, 6, font, 4);

  // bottom right (3,1)
  String[] faces7Strings = getStringSegment(f, 0.75, 1, 0.5, 1);
  faces7 = new TextDrawer(faces7Strings, 1200, 600, 255, 6, font, 4);
}

void draw() {
  stateManager.incrementFrame();
 
  background(0);

  // Dashed circle
  strokeWeight(4);
  circle.draw();
  // stroke(BLUE);
  // noFill();
  // dash.ellipse(600, 300, 50, 50);

  // Animate dashes with 'walking ants' effect
  dash.offset(dist);
  dist += 1;




  
  
  count++;
  
  float faces0Progress = stateManager.getProgressOfState("FACE_0_PROGRESS");
  faces0.drawTextByLine(faces0Progress);
  
  float faces1Progress = stateManager.getProgressOfState("FACE_1_PROGRESS");
  faces1.drawTextByLine(faces1Progress);
  
  float faces2Progress = stateManager.getProgressOfState("FACE_2_PROGRESS");
  faces2.drawTextByLine(faces2Progress);
  
  float faces3Progress = stateManager.getProgressOfState("FACE_3_PROGRESS");
  faces3.drawTextByLine(faces3Progress);
  
  float faces4Progress = stateManager.getProgressOfState("FACE_4_PROGRESS");
  faces4.drawTextByLine(faces4Progress);
  
  float faces5Progress = stateManager.getProgressOfState("FACE_5_PROGRESS");
  faces5.drawTextByLine(faces5Progress);
  
  float faces6Progress = stateManager.getProgressOfState("FACE_6_PROGRESS");
  faces6.drawTextByLine(faces6Progress);
  
  float faces7Progress = stateManager.getProgressOfState("FACE_7_PROGRESS");
  faces7.drawTextByLine(faces7Progress);
  
  
  
  
  
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
