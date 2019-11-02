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
    }

    void addState(String stateName, int startFrame) {
        states.add(new State(stateName, startFrame));
    }

    int getStateIndex() {
        for(int i = 0; i < states.size()-1; i++) {
          if(curFrame < states.get(i+1).frameStart) {
            return i;
          }
        }
        return states.size() - 1;
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
      int selectedStateIndex = -1;
      for(int i = 0; i < states.size(); i++) {
        if(states.get(i).name.equals(state)) {
          selectedStateIndex = i;
          break;
        }
      }
            
      if(selectedStateIndex != -1) {
        if(selectedStateIndex > currentStateIndex) {
          return 0.0f;
        } else if (selectedStateIndex < currentStateIndex) {
          return 1.0f;
        } else {
          return map(curFrame, states.get(currentStateIndex).frameStart, states.get(currentStateIndex + 1).frameStart, 0.0f, 1.0f);
        }
      }
      return 0.0f;
    }

    float getProgress() {
        return currentStateProgress;
    }
    
    void reset() {
      println("StateManager on " + getState() + " resetting to 0");
      curFrame = 0; 
    }
}
