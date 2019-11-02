class GenderDisplay {
    StateManager stateManager;
    int uid;
    String[] emotions = {"emotion text", "other text", "more text"};

    GenderDisplay() {
      stateManager = new StateManager();
      stateManager.addState("START_UID", 50);
      stateManager.addState("DRAW_EMOTION", 70);
      stateManager.addState("FINISH", 90);
    }

    void setup(int uid, String emotion, ArrayList<PVector> features) {
      
    }

    void draw() {
        stateManager.incrementFrame();

        float rectangleProgress = stateManager.getProgressOfState("START_UID");
        fill(255, 0, 0);
        rect(100, 100, 50, float(250) * rectangleProgress);
        println("progress: " + rectangleProgress);
        
        float textProgress = stateManager.getProgressOfState("DRAW_EMOTION"); // progress of text ranging from 0.0 to 1.0
        int textIndex = int(float(emotions.length) * textProgress); // multiply it by length of all the texts that we want to draw
        
        for ( int i = 0; i < emotions.length; i++) {
          if(textIndex > i) {
            text(emotions[i], 175, 50 + i * 20);            
          }
        }
    }
}
