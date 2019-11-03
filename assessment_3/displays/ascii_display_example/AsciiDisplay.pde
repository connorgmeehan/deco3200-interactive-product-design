class AsciiDisplay {

    TextDrawer firstLines, startingText, startingTextOK, mainFace, 
    faceA, faceB, faceC, faceD, faceE, faceF, faceG, faceH;

    StateManager stateManager;

    String firstLine = "sudo /etc/init.d/dbus restart";
    PFont font, font2;
    //String f, f2 = "starting.txt";
    //String f2 = "starting2.txt";

    int count = 0;

    int yPos_main = 200, xPos_main;
    int yPos_other, xPos_other;

    String[] cursor = {"/", "+", "."}; 

    int counter = 0;
    int counter2 = 0;
    int counter3 = 0;

    int reverseCounter;
    int stringCount;
    int ypos;

    color BLACK = 0;
    color GREEN = #6FCF97;
    color BLUE = #0029F3;
    color WHITE = 255;

    boolean blinkOn;
    String nextChar;

    AsciiDisplay() {
        font = loadFont("Menlo-Regular-5.vlw");
        font2 = loadFont("IBMPlexMono-18.vlw");
        frameRate(20);
        stateManager = new StateManager();
        stateManager.addState("INITIAL", 0);
        stateManager.addState("STARTING_LINES", 50);
        stateManager.addState("MAIN_FACE", 100);
        stateManager.addState("SUB_FACES_TOP", 150);
        stateManager.addState("SUB_FACES_BOTTOM", 170);
        stateManager.addState("SUB_FACES_WHITE_1", 190);
        stateManager.addState("SUB_FACES_WHITE_2", 195);
        stateManager.addState("SUB_FACES_WHITE_3", 200);
        stateManager.addState("SUB_FACES_WHITE_4", 205);
        stateManager.addState("END", 210);

        
        firstLines = new TextDrawer(loadStrings("firstLine.txt"), 75, 50, #6FCF97, 0, font2, 14);
        startingText = new TextDrawer(loadStrings("starting.txt"), 70, 100, 255, 10, font2, 14);
        startingTextOK = new TextDrawer(loadStrings("starting2.txt"), 70, 100, GREEN, 10, font2, 14);
        mainFace = new TextDrawer(loadStrings("main_face.txt"), 525, 370, 255, 5, font, 4);
        faceA = new TextDrawer(loadStrings("face_A.txt"), 100,  370, WHITE, 2, font, 1.5);
        faceB = new TextDrawer(loadStrings("face_B.txt"), 325,  370, WHITE, 2, font, 1.5);
        faceC = new TextDrawer(loadStrings("face_C.txt"), 975,  370, WHITE, 2, font, 1.5);
        faceD = new TextDrawer(loadStrings("face_D.txt"), 1200, 370, WHITE, 2, font, 1.5);
        faceE = new TextDrawer(loadStrings("face_E.txt"), 100,  605, WHITE, 2, font, 1.5);
        faceF = new TextDrawer(loadStrings("face_F.txt"), 325,  605, WHITE, 2, font, 1.5);
        faceG = new TextDrawer(loadStrings("face_G.txt"), 975,  605, WHITE, 2, font, 1.5);
        faceH = new TextDrawer(loadStrings("face_H.txt"), 1200, 605, WHITE, 2, font, 1.5);

        blinkOn = true;
    }

    void draw() {
        background(#06090B);
        stateManager.incrementFrame();

        // typewriteText(firstLine, 75, 50); 
        blendMode(BLEND);
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

        stateManager.drawDebug();
    }
}