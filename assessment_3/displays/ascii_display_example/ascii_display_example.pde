String[] main_face;
PFont font;

void setup() {
  size(1024, 768);
  frameRate(10);
  font = loadFont("IBMPlexMono-18.vlw");
  textFont(font, 16);
  
  main_face = loadStrings("main_face.txt");
}




void draw() {
  background(#06090B);
  fill(255);
  
  
}
