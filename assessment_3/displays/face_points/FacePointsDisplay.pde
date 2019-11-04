class FacePointsDisplay {
    StateManager state;
    
    color GREEN = #6FCF97;
    color BLUE = #0029F3;

    PFont terminalFont;
    int terminalFontSize = 14;
    int terminalLineHeight = 18;
    int miniTerminalFontSize = 10;
    int miniTerminalLineHeight = 14;

    int idFontSize = 24;
    int idLineHeight = 32;

    PVector[][] features;
    int featuresTotalCount;

    int age;
    String fakeId;
    String preConcatId, concatId;
    int concatIdLength = 2;

    BoxVisual boxVisual;
    TextDrawer initialText, preConcatIdText, concatIdText,
        gettingFeaturesText, buildingTopologyText, analysingFeaturesText, resultText, resultTextHighlight;

    FacePointsDisplay() {
        terminalFont = loadFont("IBMPlexMono-Medium-18.vlw");

        state = new StateManager();
        state.addState("INITIAL_TEXT", 10);
        state.addState("DRAW_BOX", 100);
        state.addState("DRAW_POINTS", 110);
        state.addState("DRAW_LINES", 200);
        state.addState("PRE_ANALYSIS", 350);
        state.addState("SCAN_FACE", 400);
        state.addState("ANALYSIS", 550);
        state.addState("PROGRESS", 600);
        state.addState("SHOW_ID", 650);
        state.addState("END", 680);
        boxVisual = new BoxVisual(850, 200, 700, 700);

        initialText = new TextDrawer(loadStrings("face_point_text.txt"), 20, 50, 255, miniTerminalLineHeight, terminalFont, miniTerminalFontSize);
        gettingFeaturesText = new TextDrawer("* Getting features...", 850, 100, 255, terminalLineHeight, terminalFont, terminalFontSize);
        buildingTopologyText = new TextDrawer("* Building facial topologies...", 850, 114, 255, terminalLineHeight, terminalFont, terminalFontSize);
        analysingFeaturesText = new TextDrawer("* Predicting age from features...", 850, 128, 255, terminalLineHeight, terminalFont, terminalFontSize);
    }

    void setup(String _fakeId, int _age, PVector[][] _points) {
        state.reset();
        
        age = _age;
        preConcatId = _fakeId.substring(0, concatIdLength - 2);
        concatId = _fakeId.substring(0, concatIdLength);

        features = mapPVectorsToRect(_points, 900, 250, 600, 600);
        featuresTotalCount = getVectorCount(features);
        println("featuresTotalCount: " + featuresTotalCount);
        
        concatIdText = new TextDrawer(concatId, 1100, 970, 255, idLineHeight, terminalFont, idFontSize);

        String[] resultsString = {
            "* age_analysis_response:",
            "    - age.avg   : " + _age,
            "    - age.range : ",
        };
        String[] resultsStringHighlight = {
            "",
            "                  " + _age,
            "                   [" + (_age - int(float(_age) * 0.1)) + "," + (_age + int(float(_age) * 0.1)) + "]",
        };

        resultText = new TextDrawer(resultsString, 850, 146, 255, terminalLineHeight, terminalFont, terminalFontSize);
        resultTextHighlight = new TextDrawer(resultsStringHighlight, 850, 146, GREEN, terminalLineHeight, terminalFont, terminalFontSize);

    }

    void draw() {
        state.incrementFrame();
        float initialTextProgress = state.getProgressOfState("INITIAL_TEXT");
        initialText.drawTextByLine(initialTextProgress);

        float drawBoxProgress = state.getProgressOfState("DRAW_BOX");
        boxVisual.setGap(1.0f - drawBoxProgress * 0.5f);
        boxVisual.draw();
        state.drawDebug();

        stroke(200);
        noFill();
        int lineIndex = 0;
        float drawLinesProgress = state.getProgressOfState("DRAW_LINES");
        for (int i = 0; i < features.length; i++) {
            for(int j = 0; j < features[i].length-1; j++) {
                if(lineIndex < int(float(featuresTotalCount) * drawLinesProgress)){
                    PVector thisVec = features[i][j];
                    PVector nextVec = features[i][j+1];
                    line(thisVec.x, thisVec.y, nextVec.x, nextVec.y);
                }
                lineIndex++;
            }
        }

        if(state.getState().equals("SCAN_FACE")){
            blendMode(MULTIPLY);
            float faceScanProgress = state.getProgressOfState("SCAN_FACE");
            fill(BLUE);
            rect(851, 201 + 300 + cos(faceScanProgress*TWO_PI)*299, 699, 100);
            blendMode(BLEND);
        }

        noStroke();
        fill(255);
        int vertexIndex = 0;
        float drawingPointsProgress = state.getProgressOfState("DRAW_POINTS");
        int drawingPointsIndex = int(float(featuresTotalCount) * drawingPointsProgress);
        PVector curVector = new PVector(0, 0);
        for (int i = 0; i < features.length; i++) {
            for(int j = 0; j < features[i].length; j++) {
                PVector thisVec = features[i][j];
                if(vertexIndex < drawingPointsIndex) {
                    ellipse(thisVec.x, thisVec.y, 7, 7);      
                }

                if (vertexIndex == drawingPointsIndex){
                    curVector = thisVec;
                }
                vertexIndex++;
            }
        }

        if(state.getState().equals("DRAW_POINTS")) {
            stroke(255);
            strokeWeight(1);
            line(curVector.x, curVector.y, 1500, 150);
            line(curVector.x, curVector.y, 1500, 168);
        }
        text("x: " + curVector.x, 1500, 150);
        text("y: " + curVector.y, 1500, 168);

        float preAnalysisProgress = state.getProgressOfState("PRE_ANALYSIS");
        float analysis1Progress = constrain(preAnalysisProgress*3f, 0f, 1f);
        float analysis2Progress = constrain(preAnalysisProgress*3f-1f, 0f, 1f);
        float analysis3Progress = constrain(preAnalysisProgress*3f-2f, 0f, 1f);
        gettingFeaturesText.drawTextByChar(analysis1Progress, (analysis1Progress > 0.0f && analysis1Progress < 1.0f));
        buildingTopologyText.drawTextByChar(analysis2Progress, (analysis2Progress > 0.0f && analysis2Progress < 1.0f));
        analysingFeaturesText.drawTextByChar(analysis3Progress, (analysis3Progress > 0.0f && analysis3Progress < 1.0f));

        float resultProgress = state.getProgressOfState("PROGRESS");
        resultText.drawTextByLine(resultProgress);
        resultTextHighlight.drawTextByLine(resultProgress);

        float fakeIdProgress = state.getProgressOfState("SHOW_ID");
        if(fakeIdProgress > 0.0f) {
            noStroke();
            fill(BLUE);
            int textIndex = int(fakeIdProgress * float(concatId.length()));
            rect(
                1100 - idFontSize,
                970 - idFontSize - 6,
                idFontSize * 2 + float(idFontSize) * float(textIndex) * 0.61,
                idFontSize*2
            );
        }
        concatIdText.drawTextByChar(fakeIdProgress, state.getState().equals("SHOW_ID"));
    }

    int getVectorCount(PVector[][] vects) {
        int count = 0;
        for (int i = 0; i < vects.length; i++) {
            count += vects[i].length;
        }
        return count;
    }

    PVector[][] mapPVectorsToRect(PVector[][] vects, int x, int y, int width, int height) {
        float minY = width, maxY = 0, minX = height, maxX = 0;
        for (int i = 0; i < vects.length; i++) {
            for (int j = 0; j < vects[i].length; j++) {
            PVector currentVal = vects[i][j];
            minY = constrain(currentVal.y, 0.0f, minY);
            maxY = constrain(currentVal.y, maxY, (float) height);
            minX = constrain(currentVal.x, 0.0f, minX);
            maxX = constrain(currentVal.x, maxX, (float) width);
            }
        }
        
        // map face
        for (int i = 0; i < vects.length; i++) {
            for (int j = 0; j < vects[i].length; j++) {
            PVector currentVal = vects[i][j];
            float newX = map(currentVal.x, minX, maxX, x, x + width);
            float newY = map(currentVal.y, minY, maxY, y, y + height);
            vects[i][j] = new PVector(newX, newY);
            }
        }

        return vects;
    }
}
