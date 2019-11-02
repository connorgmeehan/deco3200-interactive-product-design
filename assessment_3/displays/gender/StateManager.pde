class StateManager {
    int curFrame = 0;
    String currentState = "NULL";
    int currentStateIndex = -1;
    float currentStateProgress;
    ArrayList<State> states;
    
    StateManager() {
        states = new ArrayList<State>();
        states.add(new State("INITIAL", 0));
    }

    void incrementFrame() {
        curFrame++;
        currentStateIndex = getStateIndex();
        currentStateProgress = calculateStateProgress();
    }

    void addState(String stateName, int startFrame) {
        states.add(new State(stateName, startFrame));
    }

    int getStateIndex() {
      println("curframe: " + curFrame);
        for(int i = 0; i < states.size(); i++) {
          println("state i name:" + states.get(i).name + ", startFrame: " + states.get(i).frameStart);
          if(curFrame > states.get(i).frameStart) {
            return i;
          }
        }
        return -1;
    }

    String getState() {
      if(currentStateIndex < 0 || currentStateIndex >= states.size()) {
        return "NONE";
      }
      return states.get(currentStateIndex).name;
    }

    float calculateStateProgress() {
        if(currentStateIndex == states.size() - 1 || currentStateIndex < 0) {
            return 1.0f;
        }
        int stateLength = states.get(currentStateIndex + 1).frameStart - states.get(currentStateIndex).frameStart;
        return (float) (curFrame - states.get(currentStateIndex).frameStart) / (float) stateLength;
    }
    
    float getProgressOfState(String state) {
        for (int i = 0; i < states.size() - 1; i++) {
          State iteratedState = states.get(i);
          if (state.equals(iteratedState.name)) {
            if(curFrame > iteratedState.frameStart) {
                if(curFrame < states.get(i+1).frameStart) {
                  return calculateStateProgress(); 
                } else {
                  return 1.0f;
                }
            }
          }
        }
       return 0.0f;
    }

    float getProgress() {
        return currentStateProgress;
    }
    
    void reset() {
      curFrame = 0; 
    }
}
