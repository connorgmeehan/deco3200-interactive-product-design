
int count = 0;
String f = "main_face.txt";
PFont font;

int facesNum = 8;
GetFaceSegment[] faces = new GetFaceSegment[facesNum];


void setup() {
  background(0);
  size(1024, 768);
  frameRate(15);
  font = loadFont("Menlo-Regular-5.vlw");

  // top left (0,0)
  faces[0] =  new GetFaceSegment(f, 0, 0.25, 0, 0.5);

  // top right (0,1)
  faces[1] =  new GetFaceSegment(f, 0, 0.25, 0.5, 1);

  // top mid left (1,0)
  faces[2] =  new GetFaceSegment(f, 0.25, 0.5, 0, 0.5);

  // top mid right (1,1)
  faces[3] =  new GetFaceSegment(f, 0.25, 0.5, 0.5, 1);

  // bottom mid left (2,0)
  faces[5] =  new GetFaceSegment(f, 0.5, 0.75, 0, 0.5);

  //bottom mid right (2,1)
  faces[4] =  new GetFaceSegment(f, 0.5, 0.75, 0.5, 1);

  // bottom left (3,0)
  faces[6] =  new GetFaceSegment(f, 0.75, 1, 0, 0.5);

  // bottom right (3,1)
  faces[7] =  new GetFaceSegment(f, 0.75, 1, 0.5, 1);
}

void draw() {

  translate(100, 75);
  faces[0].draw();

  translate(0, 175);
  faces[1].draw();

  translate(0, 175);
  faces[2].draw();

  translate(0, 175 );
  faces[3].draw();

  translate(300, -525);
  faces[4].draw();

  translate(0, 175);
  faces[5].draw();

  translate(0, 175);
  faces[6].draw();

  translate(0, 175);
  faces[7].draw();
}
