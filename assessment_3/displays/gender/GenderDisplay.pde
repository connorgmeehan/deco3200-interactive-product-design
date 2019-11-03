import java.util.Vector;

class GenderDisplay {
    StateManager stateManager;
    int uid;
    boolean isMale;
    List<List<PVector>> features;
    List<PShape> shapes;
    DelaunayTriangulator delaunayTriangulator;
    PImage image;
    boolean hasImage;

    GenderDisplay() {
      stateManager = new StateManager();
      stateManager.addState("START_UID", 50);
      stateManager.addState("DRAW_FACE", 70);
      stateManager.addState("DRAW_GENDER", 150);
      stateManager.addState("FINISH", 170);
    }

    void setup(int _uid, boolean _isMale, List<List<PVector>> _features) {
      stateManager.reset();
      uid = _uid;
      isMale = _isMale;
      features = _features;
      shapes = new ArrayList<PShape>();
      image = new PImage();
      hasImage = false;

      Vector<Vector2D> pointSet = new Vector<Vector2D>();
      for(int i = 0; i < features.size(); i++) {
        for(int j = 0; j < features.get(i).size(); j+=2) {
          if(j != features.get(i).size()) {
            PVector vec = features.get(i).get(j);
            pointSet.add(new Vector2D(vec.x, vec.y));
          }
        }
      }
      println("pointSet size: " + pointSet.size());

      try {
        delaunayTriangulator = new DelaunayTriangulator(pointSet);
        delaunayTriangulator.triangulate();
      } catch (NotEnoughPointsException e) {
        println("ERROR: Not enough points...");
      }

      List<Triangle2D> triangleSoup = delaunayTriangulator.getTriangles();
      println("triangleSoup size: " + triangleSoup.size());
      for(int i = 0; i < triangleSoup.size(); i++) {
        Triangle2D triangle = triangleSoup.get(i);
        PShape shape = createShape();
        shape.beginShape();
        shape.vertex((float)triangle.a.x, (float)triangle.a.y);
        shape.vertex((float)triangle.b.x, (float)triangle.b.y);
        shape.vertex((float)triangle.c.x, (float)triangle.c.y);
        shape.endShape(CLOSE);
        shapes.add(shape);
      }
      println("GenderDisplay::setup(uid: "+uid+", isMale: "+isMale+", features.size(): " + features.size());
    }

    void draw() {
      stateManager.incrementFrame();

      float rectangleProgress = stateManager.getProgressOfState("START_UID");
      if(rectangleProgress > 0.0f) {
        fill(255, 0, 0);
        rect(0, 0, 50, float(250) * rectangleProgress);
      }
      
      float featureProgress = stateManager.getProgressOfState("DRAW_FACE"); // progress of text ranging from 0.0 to 1.0
      if(featureProgress > 0.0f) {
        int featureIndex = int(float(features.size()) * featureProgress); // multiply it by length of all the texts that we want to draw
        int shapeIndex = int(float(shapes.size()) * featureProgress);
        for ( int i = 0; i < shapes.size(); i++) {
          if(shapeIndex > i) {
            shape(shapes.get(i));
          }
        }

        fill(0, 0, 255);

        for ( int i = 0; i < features.size(); i++) {
          if(featureIndex > i) {
            for(int j = 0; j < features.get(i).size(); j++) {
              PVector vec = features.get(i).get(j);
              circle(vec.x, vec.y, 5);
            }
          }
        }
      }

      fill(0, 255, 0);
      float emotionProgress = stateManager.getProgressOfState("DRAW_GENDER");
      if(emotionProgress > 0.5f) {
        if(isMale) {
          text("MALE", 20, 20);
        } else {
          text("FEMALE", 20, 20);
        }
      }

      if(hasImage) {
        image(image, 0, 0);
      }

    }

    void setImage(PImage _image) {
      image = _image;
      hasImage = true;
    }
}
