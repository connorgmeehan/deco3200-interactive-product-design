String[] main_face, starting, starting2, starting_fail, starting3, starting3OK;
String[] face_A, face_B, face_C, face_D, face_E, face_F, face_G, face_H;
String firstLine = "sudo /etc/init.d/dbus restart";
String invisibleLine = "                                   ";
PFont font, font2;

int count = 0;

int yPos_main = 200, xPos_main;
int yPos_other, xPos_other;

String[] cursor = {"/", "+", "."}; 


int counter = 0;
int counter2 = 0;
int counter3 = 0;

int reverseCounter;
int stringCount;
int ypos;

color BLACK = 0;
color GREEN = #6FCF97;
color BLUE = #0029F3;

int blinkTime;
boolean blinkOn;
String nextChar;


void setup() {
  size(1440, 1024);

  font = loadFont("Menlo-Regular-5.vlw");
  font2 = loadFont("IBMPlexMono-18.vlw");
  frameRate(20);
  main_face = loadStrings("main_face.txt");
  starting = loadStrings("starting.txt");
  starting2 = loadStrings("starting2.txt");
  starting_fail = loadStrings("starting_fail.txt");
  starting3 = loadStrings("starting3.txt");

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
  counter = 0;
  //frameRate(1);
}


void draw() {
  background(#06090B);
  println(frameRate);
  frameRate(20);

  typewriteText(firstLine, 75, 40); 

  xPos_main = width/2;
  yPos_main = 470;
  yPos_other = 300;
  xPos_other = width/4;
  ypos = 0;
  translate(-200, -100);


  int linesIndex = 0;


  //println(count);

  // "Starting..." text
  for (int i = 0; i < starting.length; i++) {
    //frameRate(10);
    linesIndex++;
    if (linesIndex < count) {
      frameRate(10);
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
  //count++;

  // draw main face
  for (int i = 0; i < main_face.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      //frameRate(20);
      fill(255);
      textFont(font, 4);
      text("" + main_face[i] + "", xPos_main+20, yPos_main);
    }
    yPos_main += 5;
  }
  //count++;
  //frameRate(10);

  // All timed blinking cursors
  fill(GREEN);
  noStroke();
  if (count > 83 && count < 170) {
    if (blinkOn) 
      rect(1120, 304, 15, 20);
  }
  if (count > 240 && count < 310) {
    if (blinkOn) 
      rect(505, 375, 15, 20);
  }
  if (count > 450 && count < 620) {
    if (blinkOn) 
      rect(632, 375, 15, 20);
  }
  if (millis() - 500 > blinkTime) {
    blinkTime = millis();
    blinkOn = !blinkOn;
  }

  if (count > 620) {
    fill(BLUE);
    textFont(font2, 14);
    rect(636, 380, 40, 10);
    fill(255);
    text("[ OK ]", 632, 390);
  }


  // timers
  if (count > 160) {
      //if (count > 200) {
    //frameRate(10);
    textFont(font2, 14);
    fill(255);
    text("" + starting3[30] + "", 275, ypos-380);
    fill(GREEN);
    text("OK", 462, ypos-380);
  }

  if (count > 160 && count < 328) {
    //if (count > 170 && count < 328) {
    //frameRate(15);
    fill(255); 
    if (counter2 < starting3[31].length()) 
      counter2++;
    text(starting3[31].substring(0, counter2), 275, ypos-360);
  } 

  if (count > 330) {
    //frameRate(30);
    fill(255); 
    if (counter2 < starting3[32].length()) 
      counter2++;
    text(starting3[32].substring(0, counter2), 275, ypos-360);
  }

  //then draw top row of other faces
  for (int i = 0; i < face_A.length; i++) {
    linesIndex++;
    //frameRate(120);
    if (linesIndex < count) {
      fill(#6FCF97);
      textFont(font, 1.5);

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
    //frameRate(120);
    linesIndex++;
    if (linesIndex < count) {
      fill(#6FCF97);
      textFont(font, 1.5);
      //frameRate(120);
      text("" + face_E[i] + "", xPos_other-50, yPos_other+280);
      text("" + face_F[i] + "", xPos_other+170, yPos_other+280);
      text("" + face_G[i] + "", xPos_other+835, yPos_other+280);
      text("" + face_H[i] + "", xPos_other+1055, yPos_other+280);
    }
    yPos_other += 2;
  }
  //count++;


  // Reset x and y pos
  yPos_other = 300;
  xPos_other = width/4;

  //  // white scan 1
  for (int i = 0; i < face_A.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      fill(255);
      textFont(font, 1.5);
      //frameRate(120);
      if (count > 230 && count < 392) {
        text("" + face_A[i] + "", xPos_other-50, yPos_other+200);
        text("" + face_H[i] + "", xPos_other+1055, yPos_other+431);
      }
    }
    yPos_other += 2;
  }
  //  //count++;

  //  // white scan 2
  for (int i = 0; i < face_A.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      fill(255);
      textFont(font, 1.5);
      if (count > 392 && count < 471) {
        text("" + face_B[i] + "", xPos_other+170, yPos_other+50);
        text("" + face_G[i] + "", xPos_other+835, yPos_other+280);
      }
    }
    yPos_other += 2;
  }
  //  //count++;

  //  // white scan 3
  for (int i = 0; i < face_A.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      fill(255);
      textFont(font, 1.5);
      if (count > 471 && count < 540) {
        text("" + face_C[i] + "", xPos_other+835, yPos_other-100);
        text("" + face_F[i] + "", xPos_other+170, yPos_other+129);
      }
    }
    yPos_other += 2;
  }


  //  // white scan 4
  for (int i = 0; i < face_A.length; i++) {
    linesIndex++;
    if (linesIndex < count) {
      fill(255);
      textFont(font, 1.5);
      if (count > 540 && count < 630) {
        text("" + face_D[i] + "", xPos_other+1055, yPos_other-250);
        text("" + face_E[i] + "", xPos_other-50, yPos_other-21);
      }
    }
    yPos_other += 2;
  }
  count++;
  
  fill(BLUE);
  rect(width/2+200, 950, 45, 60);
  textFont(font2, 60);
  fill(255);
  text("*", width/2+205, 1000);
  
}

void typewriteText(String lines, int w, int h) {
  //frameRate(20);
  fill(255);
  textFont(font2, 14);
  if (counter < lines.length()) 
    counter++;
  text(lines.substring(0, counter), w, h);
}
