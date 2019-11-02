class GenderDisplay {
    StateManager stateManager;
    int uid;
    boolean isMale;
    ArrayList<ArrayList<PVector>> features;

    GenderDisplay() {
      stateManager = new StateManager();
      stateManager.addState("START_UID", 50);
      stateManager.addState("DRAW_FACE", 70);
      stateManager.addState("DRAW_GENDER", 150);
      stateManager.addState("FINISH", 170);
    }

    void setup(int _uid, boolean _isMale, ArrayList<ArrayList<PVector>> _features) {
      stateManager.reset();
      uid = _uid;
      isMale = _isMale;
      features = _features;
      println("GenderDisplay::setup(uid: "+uid+", emotion: "+emotion+", features.size(): " + features.size());
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
    }
}
