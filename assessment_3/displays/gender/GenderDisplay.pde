import java.util.Vector;

class GenderDisplay {
    StateManager stateManager;
    int uid;
    String fakeId;
    boolean isMale;
    List<List<PVector>> features;
    List<PShape> shapes;
    DelaunayTriangulator delaunayTriangulator;
    PImage image;
    boolean hasImage;

    BoxVisual faceBox;

    // Beth
    PFont font;
    AnalysisBar analysisBar1, analysisBar2, analysisBar3;
    color GREEN = #6FCF97;
    color OPAQUE_GREEN = color(111, 207, 151, 51);


    GenderDisplay() {
      stateManager = new StateManager();
      stateManager.addState("BOX", 50);
      stateManager.addState("DRAW_VERTS", 70);
      // stateManager.addState("FULL_BOX", 120);
      stateManager.addState("DRAW_TRI", 120);
      stateManager.addState("BAR1_PROGRESS", 150);
      stateManager.addState("BAR2_PROGRESS", 200);
      stateManager.addState("BAR3_PROGRESS", 250);
      stateManager.addState("DRAW_GENDER", 300);
      stateManager.addState("FINISH", 300);

      faceBox = new BoxVisual(125, 200, 400, 400);
      faceBox.setGap(0.0);
    }

    void setup(int _uid, String _fakeId, boolean _isMale, List<List<PVector>> _features) {
      stateManager.reset();
      uid = _uid;
      fakeId = _fakeId;
      isMale = _isMale;
      features = _features;
      shapes = new ArrayList<PShape>();
      image = new PImage();
      hasImage = false;

      float minY = height, maxY = 0, minX = width, maxX = 0;
      // get position of verts
      for (int i = 0; i < features.size(); i++) {
        for (int j = 0; j < features.get(i).size(); j++) {
          PVector currentVal = features.get(i).get(j);
          minY = constrain(currentVal.y, 0.0f, minY);
          maxY = constrain(currentVal.y, maxY, (float) height);
          minX = constrain(currentVal.x, 0.0f, minX);
          maxX = constrain(currentVal.x, maxX, (float) width);
        }
      }

      // map face
      PVector topLeft = new PVector(180, 240);
      PVector bottomRight = new PVector(475, 550);
      for (int i = 0; i < features.size(); i++) {
        for (int j = 0; j < features.get(i).size(); j++) {
          PVector currentVal = features.get(i).get(j);
          float newX = map(currentVal.x, minX, maxX, topLeft.x, bottomRight.x);   //600, 900
          float newY = map(currentVal.y, minY, maxY, topLeft.y, bottomRight.y);   //200, 500
          features.get(i).set(j, new PVector(newX, newY));
        }
      }

      Vector<Vector2D> pointSet = new Vector<Vector2D>();
      for(int i = 0; i < features.size(); i++) {
        if(i != 6 || i != 7) {
          for(int j = 0; j < features.get(i).size(); j+=2) {
            if(j != features.get(i).size()) {
              PVector vec = features.get(i).get(j);
              pointSet.add(new Vector2D(vec.x, vec.y));
            }
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
        noFill();
        PShape shape = createShape();
        shape.beginShape();
        shape.vertex((float)triangle.a.x, (float)triangle.a.y);
        shape.vertex((float)triangle.b.x, (float)triangle.b.y);
        shape.vertex((float)triangle.c.x, (float)triangle.c.y);
        shape.endShape(CLOSE);
        shape.setStroke(#33FFFF);
        shape.setFill(color(0, 0, 0, 0));
        shapes.add(shape);
      }

      // Beth's code®
      font = loadFont("IBMPlexMono-18.vlw");
      analysisBar1 = new AnalysisBar(600, 280, OPAQUE_GREEN, "*", font);
      analysisBar2 = new AnalysisBar(600, 380, OPAQUE_GREEN, "*", font);
      analysisBar3 = new AnalysisBar(600, 480, OPAQUE_GREEN, "*", font);

      // End beth's code®

      println("GenderDisplay::setup(uid: "+uid+", isMale: "+isMale+", features.size(): " + features.size());
    }

    void draw() {
      stateManager.incrementFrame();

      // Drawing box
      float rectangleProgress = stateManager.getProgressOfState("BOX");
      if(rectangleProgress > 0.0f) {
        // faceBox.setGap(1.0f - rectangleProgress);
        faceBox.setGap(0.5f);
        faceBox.draw();

     
       
      }
      
      
      float featureProgress = stateManager.getProgressOfState("DRAW_VERTS"); // progress of text ranging from 0.0 to 1.0
      if(featureProgress > 0.0f) {
        int featureIndex = int(float(features.size()) * featureProgress); // multiply it by length of all the texts that we want to draw
        fill(255, 0, 0);
        noStroke();
        for ( int i = 0; i < features.size(); i++) {
          if(featureIndex > i) {
            for(int j = 0; j < features.get(i).size(); j++) {
              PVector vec = features.get(i).get(j);
              circle(vec.x, vec.y, 5);
            }
          } 
        }

        
      }

      
      // Draw progress bars
      if(featureProgress > 0.5f) {
        analysisBar1.draw();
        analysisBar2.draw();
        analysisBar3.draw();
      }

        float bar1Progress = stateManager.getProgressOfState("BAR1_PROGRESS");
        if (bar1Progress > 0.0f && bar1Progress < 1.0f) {
          analysisBar1.setRandomizeBar(true);
          fill(111, 207, 151, random(100, 255));
          rect(random(125, 450), random(200, 300), random(20, 150), random(20, 80));

        } else {
          analysisBar1.setRandomizeBar(false);
        }

        float bar2Progress = stateManager.getProgressOfState("BAR2_PROGRESS");
        if (bar2Progress > 0.0f && bar2Progress < 1.0f) {
          analysisBar2.setRandomizeBar(true);
          fill(111, 207, 151, random(100, 255));
          rect(random(125, 450), random(300, 400), random(20, 150), random(20, 80));

        } else {
          analysisBar2.setRandomizeBar(false);
        }

        float bar3Progress = stateManager.getProgressOfState("BAR3_PROGRESS");
        if (bar3Progress > 0.0f && bar3Progress < 1.0f) {
          analysisBar3.setRandomizeBar(true);
          fill(111, 207, 151, random(100, 255));
          rect(random(125, 450), random(400, 500), random(20, 150), random(20, 80));
          
        } else {
          analysisBar3.setRandomizeBar(false);
        }

        
        
      

    float triangulateProgress = stateManager.getProgressOfState("DRAW_TRI"); // progress of text ranging from 0.0 to 1.0
      if(triangulateProgress > 0.0f) {
        faceBox.setGap(1.0f - triangulateProgress);
        faceBox.draw();
        noStroke();
        int shapeIndex = int(float(shapes.size()) * triangulateProgress);
        for ( int i = 0; i < shapes.size(); i++) {
          if(shapeIndex > i) {
            shape(shapes.get(i));
          }
        }

      }

      // if(triangulateProgress > 0.5f)






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
