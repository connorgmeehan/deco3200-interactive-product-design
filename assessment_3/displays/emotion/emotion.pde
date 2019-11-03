import java.util.Arrays;
import garciadelcastillo.dashedlines.*;


int count = 0;
String f = "main_face.txt";
PFont font, font2;

TextDrawer faces0, faces1, faces2, faces3, faces4, faces5, faces6, faces7;
StateManager stateManager;
DashedLines dash;
EllipseDrawer circleP1, circleP2, circleP3, circleP4, circleP5, circleP6, circleP7, circleP8, circleP9, circleP10;
DashedRectDrawer rectP1, rectP2, rectP3, rectP4, rectP5, rectP6, rectP7, rectP8;



float dist = 0;
color BLUE = #0029F3;
color WHITE = 255;
color RED = #DC3F36;


void setup() {
  background(0);
  size(1440, 1024);
  strokeWeight(0);
  frameRate(15);
  font = loadFont("Menlo-Regular-5.vlw");
  font2 = loadFont("IBMPlexMono-Medium-18.vlw");


  dash = new DashedLines(this);
  dash.pattern(6, 8);

  circleP1 = new EllipseDrawer(150, 400, BLUE, "P1", true);
  circleP5 = new EllipseDrawer(150, 475, BLUE, "P5", false);
  circleP6 = new EllipseDrawer(225, 500, BLUE, "P6", false);
  circleP7 = new EllipseDrawer(300, 525, BLUE, "P7", false);
  circleP2 = new EllipseDrawer(300, 450, BLUE, "P2", true);

  circleP3 = new EllipseDrawer(450, 400, BLUE, "P3", true);
  circleP8 = new EllipseDrawer(450, 475, BLUE, "P8", false);
  circleP9 = new EllipseDrawer(525, 500, BLUE, "P9", false);
  circleP10 = new EllipseDrawer(600, 525, BLUE, "P10", false);
  circleP4 = new EllipseDrawer(600, 450, BLUE, "P14", true);


  rectP1 = new DashedRectDrawer(825, 150, WHITE, "P1");
  rectP2 = new DashedRectDrawer(825, 350, WHITE, "P2");
  rectP3 = new DashedRectDrawer(825, 550, WHITE, "P3");
  rectP4 = new DashedRectDrawer(825, 750, WHITE, "P4");
  rectP5 = new DashedRectDrawer(1125, 150, WHITE, "P5");
  rectP6 = new DashedRectDrawer(1125, 350, WHITE, "P6");
  rectP7 = new DashedRectDrawer(1125, 550, WHITE, "P7");
  rectP8 = new DashedRectDrawer(1125, 750, WHITE, "P8");


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
  faces0 = new TextDrawer(faces0Strings, 825, 150, 255, 6, font, 4);

  // top right (0,1)
  String[] faces1Strings = getStringSegment(f, 0, 0.25, 0.5, 1);
  faces1 = new TextDrawer(faces1Strings, 825, 350, 255, 6, font, 4); 

  // top mid left (1,0)
  String[] faces2Strings = getStringSegment(f, 0.25, 0.5, 0, 0.5);
  faces2 = new TextDrawer(faces2Strings, 825, 550, 255, 6, font, 4); 

  // top mid right (1,1)
  String[] faces3Strings = getStringSegment(f, 0.25, 0.5, 0.5, 1);
  faces3 = new TextDrawer(faces3Strings, 825, 750, 255, 6, font, 4); 

  // bottom mid left (2,0)
  String[] faces4Strings = getStringSegment(f, 0.5, 0.75, 0, 0.5);
  faces4 = new TextDrawer(faces4Strings, 1125, 150, 255, 6, font, 4);

  //bottom mid right (2,1)
  String[] faces5Strings = getStringSegment(f, 0.5, 0.75, 0.5, 1);
  faces5 = new TextDrawer(faces5Strings, 1125, 350, 255, 6, font, 4);


  // bottom left (3,0)
  String[] faces6Strings = getStringSegment(f, 0.75, 1, 0, 0.5);
  faces6 = new TextDrawer(faces6Strings, 1125, 550, 255, 6, font, 4);

  // bottom right (3,1)
  String[] faces7Strings = getStringSegment(f, 0.75, 1, 0.5, 1);
  faces7 = new TextDrawer(faces7Strings, 1125, 750, 255, 6, font, 4);
}

void draw() {
  stateManager.incrementFrame();
 
  background(0);

  // Animate dashes with 'walking ants' effect
  dash.offset(dist);
  dist += 1;
    
  count++;
  


  float faces0Progress = stateManager.getProgressOfState("FACE_0_PROGRESS");
  faces0.drawTextByLine(faces0Progress);
  
  float faces1Progress = stateManager.getProgressOfState("FACE_1_PROGRESS");
  faces1.drawTextByLine(faces1Progress);
  if(faces1Progress > 0.0f) {
    // textFont(font2, 18);
    // text("P1", 750, 200);
    circleP1.draw();
    circleP2.draw();
    circleP3.draw();
    circleP4.draw();
    circleP5.draw();
    circleP6.draw();
    circleP7.draw();
    circleP8.draw();
    circleP9.draw();
    circleP10.draw();

    rectP1.draw();
    rectP2.draw();
    rectP3.draw();
    rectP4.draw();
    rectP5.draw();
    rectP6.draw();
    rectP7.draw();
    rectP8.draw();
    
  }
  
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
