import java.util.Arrays;
import garciadelcastillo.dashedlines.*;


int count = 0;
String f = "main_face.txt";
PFont font, font2;

TextDrawer faces1, faces2, faces3, faces4, faces5, faces6, faces7, faces8;
StateManager stateManager;
DashedLines dash;
EllipseDrawer circleP1, circleP2, circleP3, circleP4, circleP5, circleP6, circleP7, circleP8, circleP9, circleP10, circleP11, circleP12, circleP13, circleP14;
DashedRectDrawer rect1, rect2, rect3, rect4, rect5, rect6, rect7, rect8;



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

  circleP1 = new EllipseDrawer(175, 375, BLUE, "P1", true);
  circleP2 = new EllipseDrawer(325, 425, BLUE, "P2", true); 
  circleP3 = new EllipseDrawer(450, 425, BLUE, "P3", true); 
  circleP4 = new EllipseDrawer(600, 475, BLUE, "P4", true); 

  circleP5 = new EllipseDrawer(175, 450, BLUE, "P5", false); 
  circleP6 = new EllipseDrawer(250, 475, BLUE, "P6", false); 
  circleP7 = new EllipseDrawer(325, 500, BLUE, "P7", false); 
  

  
  circleP8 = new EllipseDrawer(450, 500, BLUE, "P8", false);  
  circleP9 = new EllipseDrawer(525, 525, BLUE, "P9", false); 
  circleP10 = new EllipseDrawer(600, 550, BLUE, "P10", false);  
    

  circleP11 = new EllipseDrawer(325, 675, WHITE, "P11", true);
  circleP12 = new EllipseDrawer(235, 715, WHITE, "P12", false);
  circleP13 = new EllipseDrawer(315, 750, WHITE, "P13", false);
  circleP14 = new EllipseDrawer(415, 745, WHITE, "P14", false);


  rect1 = new DashedRectDrawer(825, 150, WHITE, "P1");
  rect2 = new DashedRectDrawer(1125, 150, WHITE, "P2");
  rect3 = new DashedRectDrawer(825, 350, WHITE, "P3");
  rect4 = new DashedRectDrawer(1125, 350, WHITE, "P4");
  
  rect5 = new DashedRectDrawer(825, 550, WHITE, "P11"); 
  rect6 = new DashedRectDrawer(1125, 550, WHITE, "P12");
  rect7 = new DashedRectDrawer(825, 750, WHITE, "P13"); 
  rect8 = new DashedRectDrawer(1125, 750, WHITE, "P14");


  stateManager = new StateManager();
  stateManager.addState("FACE_1_PROGRESS", 0);
  stateManager.addState("FACE_2_PROGRESS", 10);
  stateManager.addState("FACE_3_PROGRESS", 20);
  stateManager.addState("FACE_4_PROGRESS", 30);
  stateManager.addState("FACE_5_PROGRESS", 40);
  stateManager.addState("FACE_6_PROGRESS", 50);
  stateManager.addState("FACE_7_PROGRESS", 60);
  stateManager.addState("FACE_8_PROGRESS", 70);
  stateManager.addState("END", 80);

  // top left (0,0)
  String[] faces1Strings = getStringSegment(f, 0, 0.25, 0, 0.5); 
  faces1 = new TextDrawer(faces1Strings, 825, 150, 255, 6, font, 4);

// bottom mid left (2,0) 
  String[] faces2Strings = getStringSegment(f, 0.25, 0.5, 0, 0.5); 
  faces2 = new TextDrawer(faces2Strings, 1125, 150, 255, 6, font, 4);

  // top right (0,1)
  String[] faces3Strings = getStringSegment(f, 0.25, 0.5, 0.5, 1); 
  faces3 = new TextDrawer(faces3Strings, 825, 350, 255, 6, font, 4); 

 //bottom mid right (2,1)
  String[] faces4Strings = getStringSegment(f, 0, 0.25, 0.5, 1);
  faces4 = new TextDrawer(faces4Strings, 1125, 350, 255, 6, font, 4);


  // top mid left (1,0)
  String[] faces5Strings = getStringSegment(f, 0.5, 0.75, 0.5, 1); 
  faces5 = new TextDrawer(faces5Strings, 825, 550, 255, 6, font, 4); 

  // bottom left (3,0)
  String[] faces6Strings = getStringSegment(f, 0.5, 0.75, 0, 0.5); 
  faces6 = new TextDrawer(faces6Strings, 1125, 550, 255, 6, font, 4);

  // top mid right (1,1)
  String[] faces7Strings = getStringSegment(f, 0.75, 1, 0, 0.5);
  faces7 = new TextDrawer(faces7Strings, 825, 750, 255, 6, font, 4); 

  // bottom right (3,1)
  String[] faces8Strings = getStringSegment(f, 0.75, 1, 0.5, 1);
  faces8 = new TextDrawer(faces8Strings, 1125, 750, 255, 6, font, 4);
}

void draw() {
  stateManager.incrementFrame();
 
  background(0);

  // Animate dashes with 'walking ants' effect
  dash.offset(dist);
  dist += 1;
    
  count++;
  


  float faces1Progress = stateManager.getProgressOfState("FACE_1_PROGRESS");
  faces1.drawTextByLine(faces1Progress);
  if(faces1Progress > 0.0f) {
    circleP1.draw();
    rect1.draw();

  }

  float faces2Progress = stateManager.getProgressOfState("FACE_2_PROGRESS");
  faces2.drawTextByLine(faces2Progress);
  if(faces2Progress > 0.0f) {
    circleP2.draw();
    rect2.draw();

  }

  float faces3Progress = stateManager.getProgressOfState("FACE_3_PROGRESS");
  faces3.drawTextByLine(faces3Progress);
  if(faces3Progress > 0.0f) {
    circleP3.draw();
    rect3.draw();    
  }

  float faces4Progress = stateManager.getProgressOfState("FACE_4_PROGRESS");
  faces4.drawTextByLine(faces4Progress);
    if(faces4Progress > 0.0f) {
      circleP4.draw();
      rect4.draw();
    }
    
  if(faces4Progress > 0.15f) {
        circleP5.draw();
      }

        
  if(faces4Progress > 0.3f) {
        circleP6.draw();
      }


    if(faces4Progress > 0.45f) {
      circleP7.draw();
    }

    if(faces4Progress > 0.6f) {
      circleP8.draw();

    } 

    if(faces4Progress > 0.75f) {
      circleP9.draw();

    } 

    if(faces4Progress > 0.9f) {
      circleP10.draw();

    } 

 
  
  float faces5Progress = stateManager.getProgressOfState("FACE_5_PROGRESS");
  faces5.drawTextByLine(faces5Progress);
  if(faces5Progress > 0.0f) {
    circleP11.draw();
    rect5.draw();

  }
  

  float faces6Progress = stateManager.getProgressOfState("FACE_6_PROGRESS");
  faces6.drawTextByLine(faces6Progress);
  if(faces6Progress > 0.0f) {
      circleP12.draw();
      rect6.draw();

    }



  float faces7Progress = stateManager.getProgressOfState("FACE_7_PROGRESS");
  faces7.drawTextByLine(faces7Progress);
  if(faces7Progress > 0.0f) {
    circleP13.draw();
    rect7.draw();

  }
  
  

  
  float faces8Progress = stateManager.getProgressOfState("FACE_8_PROGRESS");
  faces8.drawTextByLine(faces8Progress);
  if(faces8Progress > 0.0f) {
    circleP14.draw();
    rect8.draw();

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
