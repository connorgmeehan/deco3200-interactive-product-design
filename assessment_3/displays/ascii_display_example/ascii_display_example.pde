String[] main_face, starting, starting2, starting_fail, starting3, starting3OK;
String[] face_A, face_B, face_C, face_D, face_E, face_F, face_G, face_H;
String firstLine = "sudo /etc/init.d/dbus restart ";

PFont font, font2;

int count = 0;

int yPos_main = 200, xPos_main;
int yPos_other, xPos_other;

String[] cursor = {"/", "+", "."}; 


int counter;
int stringCount;
int ypos;

color BLACK = 0;
color GREEN = #6FCF97;


int blinkTime;
boolean blinkOn;
String nextChar;


void setup() {
  size(1440, 1024);
  frameRate(10);
  font = loadFont("Menlo-Regular-5.vlw");
  font2 = loadFont("IBMPlexMono-18.vlw");

  main_face = loadStrings("main_face.txt");
  starting = loadStrings("starting.txt");
  starting2 = loadStrings("starting2.txt");
  starting_fail = loadStrings("starting_fail.txt");
  starting3 = loadStrings("starting3.txt");
  //newPersonDetect = loadStrings("newPersonDetect_OK.txt");

  face_A = loadStrings("face_A.txt");
  face_B = loadStrings("face_B.txt");
  face_C = loadStrings("face_C.txt");
  face_D = loadStrings("face_D.txt");
  face_E = loadStrings("face_E.txt");
  face_F = loadStrings("face_F.txt");
  face_G = loadStrings("face_G.txt");
  face_H = loadStrings("face_H.txt");

  smooth();

  blinkTime = millis();
  blinkOn = true;
}


void draw() {
  background(#06090B);
  stringCount++;

  typewriteText(firstLine);

  //lineByLine();
  //println(count);
  xPos_main = width/2;
  yPos_main = height/2;
  yPos_other = height/3;
  xPos_other = width/4;
  ypos = 0;
  translate(-200, -100);

  int linesIndex = 0;
  //int totalIndex = 0;


  if (count > 80) {
    fill(GREEN);
    noStroke();
    //strokeWeight(20);
    if (blinkOn) 
      rect(1120, 304, 15, 20);
    //line(1118, 305, 1118, 315);
    if (millis() - 500 > blinkTime) {
      blinkTime = millis();
      blinkOn = !blinkOn;
    }
  }




  //  strokeWeight(6);
  //  stroke(#DC3F36);
  //  fill(#DC3F36);

  //if (blinkOn) 

  //  if (millis() - 500 > blinkTime) {
  //    for (int i = 0; i < cursor.length; i++) {
  //       totalIndex++;
  //      if (totalIndex > stringCount) {
  //        text(cursor[i], 1124, 310);

  //    blinkTime = millis();
  //    blinkOn = !blinkOn;
  //      }
  //  }
  //}

  //println(newPersonDetect.length);
  //println(newPersonDetect_OK.length);

  // "Starting..." text
  for (int i = 0; i < starting.length; i++) {
    frameRate(10);
    linesIndex++;
    if (linesIndex < count) {
      fill(255);
      textFont(font2, 14);
      text("" + starting[i] + "", 275, ypos-400);
      fill(#6FCF97);
      text("" + starting2[i] + "", 275, ypos-400);
      fill(#DC3F36);
      text("" + starting_fail[i] + "", 275, ypos-400);
    }
    ypos += 10;
  }



  // draw main face
  for (int i = 0; i < main_face.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      frameRate(20);
      fill(255);
      textFont(font, 4);
      text("" + main_face[i] + "", xPos_main+20, yPos_main);
    }
    yPos_main += 5;
  }

  if (count > 170) {
    textFont(font2, 14);
    text("" + starting3[30] + "", 275, ypos-380);
    fill(GREEN);
    text("OK", 462, ypos-380);
  }
  
  if (count > 210) {
    fill(255); 
    text("" + starting3[32] + "", 275, ypos-360); 
  }
  
  
  
  
  
  println(starting3[30]);

  //// Type newPersonDetect
  //ypos = 0;
  //for (int j = 0; j < starting3.length; j++) {
  //  linesIndex++;
  //  if (linesIndex < count) {
  //    textFont(font2, 14);
  //    frameRate(10);
  //    fill(GREEN);

  //    text("" + starting3[j] + "", 275, ypos+ 60);
  //    //fill(GREEN);
  //    //text("" + newPersonDetect_OK[j] + "", 275, ypos+ 60);
  //  }
  //  ypos += 10;
  //}

  //text("" + starting3[j] + "", 275, ypos+ 60);

  // then draw top row of other faces
  for (int i = 0; i < face_A.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      fill(#6FCF97);
      textFont(font, 1.5);
      frameRate(120);
      text("" + face_A[i] + "", xPos_other-50, yPos_other+200);
      text("" + face_B[i] + "", xPos_other+170, yPos_other+200);
      text("" + face_C[i] + "", xPos_other+835, yPos_other+200);
      text("" + face_D[i] + "", xPos_other+1055, yPos_other+200);
    }
    yPos_other += 2;
  }
  count++;



  // then draw bottom row of other faces
  for (int i = 0; i < face_A.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      fill(#6FCF97);
      textFont(font, 1.5);
      frameRate(120);
      text("" + face_E[i] + "", xPos_other-50, yPos_other+280);
      text("" + face_F[i] + "", xPos_other+170, yPos_other+280);
      text("" + face_G[i] + "", xPos_other+835, yPos_other+280);
      text("" + face_H[i] + "", xPos_other+1055, yPos_other+280);
    }
    yPos_other += 2;
  }
  count++;
}

void typewriteText(String lines) {
  frameRate(20);
  fill(255);
  textFont(font2, 14);
  if (counter < lines.length())
    counter++;
  text(lines.substring(0, counter), 75, 40, width, height);
}
