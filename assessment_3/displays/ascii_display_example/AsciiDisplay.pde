import java.util.Arrays;
import java.util.List;

class AsciiDisplay {
    List<List<String>> faces = new ArrayList<List<String>>();

    TextDrawer firstLines, startingText, startingTextOK, mainFace, 
    faceA, faceB, faceC, faceD, faceE, faceF, faceG, faceH,
    personDetect, personDetectOk, confidenceCheck, confidenceResults, analysisResults, passingResults, closingLambda, fakeIdDrawer;

    List<String> resultString;
    int concatLength = 4;
    String concatenatedId;

    StateManager stateManager;

    PFont font, font2;

    String[] cursor = {"/", "+", "."}; 

    color BLACK = 0;
    color GREEN = #6FCF97;
    color BLUE = #0029F3;
    color WHITE = 255;

    AsciiDisplay() {
        String[][] facesArray = new String[][] {
            loadStrings("main_face.txt"),
            loadStrings("face_A.txt"),
            loadStrings("face_B.txt"),
            loadStrings("face_C.txt"),
            loadStrings("face_D.txt"),
            loadStrings("face_E.txt"),
            loadStrings("face_F.txt"),
            loadStrings("face_G.txt"),
            loadStrings("face_H.txt"),
        };

        for (int i = 0; i < facesArray.length; i++) {
            faces.add(Arrays.asList(facesArray[i]));
        }

        font = loadFont("Menlo-Regular-5.vlw");
        font2 = loadFont("IBMPlexMono-18.vlw");
        frameRate(20);
        stateManager = new StateManager();
        stateManager.addState("INITIAL", 0);
        stateManager.addState("FIRST_LINE", 5);
        stateManager.addState("STARTING_LINES", 10);
        stateManager.addState("MAIN_FACE", 15);
        stateManager.addState("SUB_FACES_TOP", 20);
        stateManager.addState("SUB_FACES_BOTTOM", 25);
        stateManager.addState("SUB_FACES_WHITE_1", 30);
        stateManager.addState("SUB_FACES_WHITE_2", 35);
        stateManager.addState("SUB_FACES_WHITE_3", 40);
        stateManager.addState("SUB_FACES_WHITE_4", 45);
        stateManager.addState("PERSON_DETECT", 50);
        stateManager.addState("PAUSE", 60);
        stateManager.addState("CONFIDENCE_CHECK", 70);
        stateManager.addState("CONFIDENCE_RESULTS", 80);
        stateManager.addState("PASSING_RESULTS", 120);
        stateManager.addState("SHUTTING_LAMBDA", 150);
        stateManager.addState("END", 170);

        firstLines = new TextDrawer(loadStrings("firstLine.txt"), 70, 75, WHITE, 10, font2, 14);
        firstLines.setCaretColor(#6FCF97);
        startingText = new TextDrawer(loadStrings("starting.txt"), 70, 100, 255, 10, font2, 14);
        startingTextOK = new TextDrawer(loadStrings("starting2.txt"), 70, 100, GREEN, 10, font2, 14);
        personDetect = new TextDrawer(loadStrings("newPersonDetect.txt"), 70, 300, WHITE, 10, font2, 14);
        personDetect.setCaretColor(GREEN);
        personDetectOk = new TextDrawer(loadStrings("newPersonDetect_OK.txt"), 70, 300, GREEN, 10, font2, 14);
    
        confidenceCheck = new TextDrawer(loadStrings("confidenceCheck.txt"), 70, 312, WHITE, 10, font2, 14);
        confidenceCheck.setCaretColor(GREEN);

        confidenceResults = new TextDrawer(loadStrings("confidenceResults.txt"), 70, 650, WHITE, 10, font2, 14);
    }

    void setup(String fakeId, String[] newFace) {
        println("fakeId: "+fakeId);
        concatenatedId = fakeId.substring(0, concatLength);
        println("concatenatedId: "+concatenatedId);
        
        faces.add(0, Arrays.asList(newFace));
        faces.remove(faces.size() - 1);
        stateManager.reset();
        mainFace = new TextDrawer(faces.get(0), 525, 370, 255, 5, font, 4);
        faceA = new TextDrawer(faces.get(1), 100,  370, WHITE, 2, font, 1.5);
        faceB = new TextDrawer(faces.get(2), 325,  370, WHITE, 2, font, 1.5);
        faceC = new TextDrawer(faces.get(3), 975,  370, WHITE, 2, font, 1.5);
        faceD = new TextDrawer(faces.get(4), 1200, 370, WHITE, 2, font, 1.5);
        faceE = new TextDrawer(faces.get(5), 100,  605, WHITE, 2, font, 1.5);
        faceF = new TextDrawer(faces.get(6), 325,  605, WHITE, 2, font, 1.5);
        faceG = new TextDrawer(faces.get(7), 975,  605, WHITE, 2, font, 1.5);
        faceH = new TextDrawer(faces.get(8), 1200, 605, WHITE, 2, font, 1.5);
        resultString = new ArrayList<String>();
        resultString.add("* new_figure_detect:");
        resultString.add("    - figure.id:"+concatenatedId);
        resultString.add("    - figure.isNew: TRUE");
        resultString.add("    - figure.confidence: "+(random(30)+70f)+"");
        analysisResults = new TextDrawer(resultString, 70, 800, 255, 20, font2, 14);
        
        fakeIdDrawer = new TextDrawer(concatenatedId, 554, 800, 255, 28, font2, 28);

        String[] passingResultsString = {"Returning " + concatenatedId + " features to DATABASE_HOST... 200 OK"};
        passingResults = new TextDrawer(passingResultsString, 70, 880, WHITE, 10, font2, 14);
        passingResults.setCaretColor(GREEN);

        String[] closingLambdaString = {"Killing lambba function..."};
        closingLambda = new TextDrawer(closingLambdaString, 70, 900, WHITE, 10, font2, 14);
        closingLambda.setCaretColor(GREEN);
    }

    void draw() {
        background(#06090B);
        stateManager.incrementFrame();

        blendMode(BLEND);
        float firstLinesProgress = stateManager.getProgressOfState("FIRST_LINE");
        firstLines.drawTextByChar(firstLinesProgress, stateManager.getState().equals("FIRST_LINE")); 
        // Starting lines
        float startingLinesProgress = stateManager.getProgressOfState("STARTING_LINES");
        startingText.drawTextByLine(startingLinesProgress);
        startingTextOK.drawTextByLine(startingLinesProgress);
        // Main face
        float mainFaceProgress = stateManager.getProgressOfState("MAIN_FACE");
        mainFace.drawTextByLine(mainFaceProgress);
        
        // subfaces
        float subfaceWhite1Progress = stateManager.getProgressOfState("SUB_FACES_WHITE_1");
        float subfaceWhite2Progress = stateManager.getProgressOfState("SUB_FACES_WHITE_2");
        float subfaceWhite3Progress = stateManager.getProgressOfState("SUB_FACES_WHITE_3");
        float subfaceWhite4Progress = stateManager.getProgressOfState("SUB_FACES_WHITE_4");

        float subfaceTopProgress = stateManager.getProgressOfState("SUB_FACES_TOP");
        faceA.drawTextByLine(subfaceTopProgress);
        faceB.drawTextByLine(subfaceTopProgress);
        faceC.drawTextByLine(subfaceTopProgress);
        faceD.drawTextByLine(subfaceTopProgress);

        float subfaceBottomProgress = stateManager.getProgressOfState("SUB_FACES_BOTTOM");
        faceE.drawTextByLine(subfaceBottomProgress);
        faceF.drawTextByLine(subfaceBottomProgress);
        faceG.drawTextByLine(subfaceBottomProgress);
        faceH.drawTextByLine(subfaceBottomProgress);

        // Subfaces green overlay
        blendMode(MULTIPLY);
        fill(GREEN);
        if(!stateManager.getState().equals("SUB_FACES_WHITE_1")) {
            rect(faceA.x, faceA.y - 2, 200, 200);
            rect(faceH.x, faceH.y - 2, 200, 200);
        } else {
            rect(faceA.x, faceA.y - 2 + subfaceWhite1Progress * 200, 200, 200 - subfaceWhite1Progress * 200);
            rect(faceH.x, faceH.y - 2 + subfaceWhite1Progress * 200, 200, 200 - subfaceWhite1Progress * 200);
        }

        if(!stateManager.getState().equals("SUB_FACES_WHITE_2")) {
            rect(faceB.x, faceB.y - 2, 200, 200);
            rect(faceG.x, faceG.y - 2, 200, 200);
        } else {
            rect(faceB.x, faceB.y - 2 + subfaceWhite2Progress * 200, 200, 200 - subfaceWhite2Progress * 200);
            rect(faceG.x, faceG.y - 2 + subfaceWhite2Progress * 200, 200, 200 - subfaceWhite2Progress * 200);
        }

        if(!stateManager.getState().equals("SUB_FACES_WHITE_3")) {
            rect(faceC.x, faceC.y - 2, 200, 200);
            rect(faceF.x, faceF.y - 2, 200, 200);
        } else {
            rect(faceC.x, faceC.y - 2 + subfaceWhite3Progress * 200, 200, 200 - subfaceWhite3Progress * 200);
            rect(faceF.x, faceF.y - 2 + subfaceWhite3Progress * 200, 200, 200 - subfaceWhite3Progress * 200);
        }

        if(!stateManager.getState().equals("SUB_FACES_WHITE_4")) {
            rect(faceD.x, faceD.y - 2, 200, 200);
            rect(faceE.x, faceE.y - 2, 200, 200);
        } else {
            rect(faceD.x, faceD.y - 2 + subfaceWhite4Progress * 200, 200, 200 - subfaceWhite4Progress * 200);
            rect(faceE.x, faceE.y - 2 + subfaceWhite4Progress * 200, 200, 200 - subfaceWhite4Progress * 200);
        }

        blendMode(BLEND);

        float personDetectProgress = stateManager.getProgressOfState("PERSON_DETECT");
        personDetect.drawTextByChar(personDetectProgress, stateManager.getState().equals("PERSON_DETECT"));
        personDetectOk.drawTextByChar(personDetectProgress, false);
        
        float confidenceCheckProgress = stateManager.getProgressOfState("CONFIDENCE_CHECK");
        if(confidenceCheckProgress > 0.89) {
            fill(BLUE);
            rect(confidenceCheck.x + 49 * 12 * 0.628, confidenceCheck.y - 12, 12 * 0.62 * 4, 15);
        }
        confidenceCheck.drawTextByChar(confidenceCheckProgress, stateManager.getState().equals("CONFIDENCE_CHECK"));
        
        float confidenceResultsProgress = stateManager.getProgressOfState("CONFIDENCE_RESULTS");
        analysisResults.drawTextByLine(confidenceResultsProgress);
        fill(BLUE);
        if(confidenceResultsProgress > 1/concatLength) {
            int textIndex = int(confidenceResultsProgress * float(concatLength));
            rect(525, 762, 28 * 2 + float(28) * float(textIndex) * 0.61, 48);
        }
        fakeIdDrawer.drawTextByChar(confidenceResultsProgress);

        float passingProgress = stateManager.getProgressOfState("PASSING_RESULTS");
        passingResults.drawTextByChar(passingProgress, stateManager.getState().equals("PASSING_RESULTS"));
        float shuttingProgress = stateManager.getProgressOfState("SHUTTING_LAMBDA");
        closingLambda.drawTextByChar(shuttingProgress, shuttingProgress > 0.01f);
        

        stateManager.drawDebug();
    }
}