import java.util.Arrays;
import garciadelcastillo.dashedlines.*;

class EmotionDisplay {
    DashedLines dash;
    PFont font, font2;

    float dist = 0;
    color BLUE = #0029F3;
    color WHITE = 255;
    color RED = #DC3F36;

    int asciiFontSize = 12;
    int asciiLineHeight = 12;

    TextDrawer faces1, faces2, faces3, faces4, faces5, faces6, faces7, faces8;
    StateManager stateManager;
    EllipseDrawer circleP1, circleP2, circleP3, circleP4, circleP5, circleP6, circleP7, circleP8, circleP9, circleP10, circleP11, circleP12, circleP13, circleP14;
    DashedRectDrawer rect1, rect2, rect3, rect4, rect5, rect6, rect7, rect8;

    EmotionDisplay(DashedLines _dash) {
        dash = _dash;
        
        font = loadFont("Menlo-Regular-5.vlw");
        font2 = loadFont("IBMPlexMono-Medium-18.vlw");

        stateManager = new StateManager();
        stateManager.addState("FACE_1_PROGRESS", 0);
        stateManager.addState("FACE_2_PROGRESS", 10);
        stateManager.addState("FACE_3_PROGRESS", 20);
        stateManager.addState("FACE_4_PROGRESS", 30);
        stateManager.addState("FACE_5_PROGRESS", 40);
        stateManager.addState("FACE_6_PROGRESS", 50);
        stateManager.addState("FACE_7_PROGRESS", 60);
        stateManager.addState("FACE_8_PROGRESS", 70);
        stateManager.addState("END", 80);

    }

    void setup(String fakeId, String[] face) {
        // top left (0,0)
        String[] faces1Strings = getStringSegment(face, 0, 0.5, 0, 0.5); 
        faces1 = new TextDrawer(faces1Strings, 825, 150, 255, asciiLineHeight, font2, asciiFontSize);
        // bottom mid left (2,0) 
        String[] faces2Strings = getStringSegment(face, 0.25, 0.75, 0, 0.5); 
        faces2 = new TextDrawer(faces2Strings, 1125, 150, 255, asciiLineHeight, font2, asciiFontSize);
        // top right (0,1)
        String[] faces3Strings = getStringSegment(face, 0, 0.5, 0.25, 0.75); 
        faces3 = new TextDrawer(faces3Strings, 825, 350, 255, asciiLineHeight, font2, asciiFontSize); 
        //bottom mid right (2,1)
        String[] faces4Strings = getStringSegment(face, 0, 0.5, 0.5, 1);
        faces4 = new TextDrawer(faces4Strings, 1125, 350, 255, asciiLineHeight, font2, asciiFontSize);
        // top mid left (1,0)
        String[] faces5Strings = getStringSegment(face, 0.5, 1.0, 0.25, 0.75); 
        faces5 = new TextDrawer(faces5Strings, 825, 550, 255, asciiLineHeight, font2, asciiFontSize); 
        // bottom left (3,0)
        String[] faces6Strings = getStringSegment(face, 0.5, 1.0, 0, 0.5); 
        faces6 = new TextDrawer(faces6Strings, 1125, 550, 255, asciiLineHeight, font2, asciiFontSize);
        // top mid right (1,1)
        String[] faces7Strings = getStringSegment(face, 0.5, 1, 0.25, 0.75);
        faces7 = new TextDrawer(faces7Strings, 825, 750, 255, asciiLineHeight, font2, asciiFontSize); 
        // bottom right (3,1)
        String[] faces8Strings = getStringSegment(face, 0.5, 1, 0.5, 1);
        faces8 = new TextDrawer(faces8Strings, 1125, 750, 255, asciiLineHeight, font2, asciiFontSize);

        rect1 = new DashedRectDrawer(dash,  825, 150, int(float(faces1Strings[0].length() * asciiFontSize) * 0.61) , faces1Strings.length * asciiLineHeight, WHITE, "P1");
        rect2 = new DashedRectDrawer(dash, 1125, 150, int(float(faces2Strings[0].length() * asciiFontSize) * 0.61) , faces2Strings.length * asciiLineHeight, WHITE, "P2");
        rect3 = new DashedRectDrawer(dash,  825, 350, int(float(faces3Strings[0].length() * asciiFontSize) * 0.61) , faces3Strings.length * asciiLineHeight, WHITE, "P3");
        rect4 = new DashedRectDrawer(dash, 1125, 350, int(float(faces4Strings[0].length() * asciiFontSize) * 0.61) , faces4Strings.length * asciiLineHeight, WHITE, "P4");
        rect5 = new DashedRectDrawer(dash,  825, 550, int(float(faces5Strings[0].length() * asciiFontSize) * 0.61) , faces5Strings.length * asciiLineHeight, WHITE, "P11"); 
        rect6 = new DashedRectDrawer(dash, 1125, 550, int(float(faces6Strings[0].length() * asciiFontSize) * 0.61) , faces6Strings.length * asciiLineHeight, WHITE, "P12");
        rect7 = new DashedRectDrawer(dash,  825, 750, int(float(faces7Strings[0].length() * asciiFontSize) * 0.61) , faces7Strings.length * asciiLineHeight, WHITE, "P13"); 
        rect8 = new DashedRectDrawer(dash, 1125, 750, int(float(faces8Strings[0].length() * asciiFontSize) * 0.61) , faces8Strings.length * asciiLineHeight, WHITE, "P14");

        circleP1 = new EllipseDrawer(dash, random(165, 185), random(365, 385), BLUE, "P1", true);
        circleP2 = new EllipseDrawer(dash, random(320, 330), random(415, 435), BLUE, "P2", true); 
        circleP3 = new EllipseDrawer(dash, random(440, 460), random(415, 435), BLUE, "P3", true); 
        circleP4 = new EllipseDrawer(dash, random(590, 610), random(465, 485), BLUE, "P4", true); 
        circleP5 = new EllipseDrawer(dash, random(165, 185), random(440, 460), BLUE, "P5", false); 
        circleP6 = new EllipseDrawer(dash, random(240, 260), random(465, 480), BLUE, "P6", false); 
        circleP7 = new EllipseDrawer(dash, random(315, 335), random(490, 510), BLUE, "P7", false); 
        circleP8 = new EllipseDrawer(dash, random(440, 460), random(490, 510), BLUE, "P8", false);  
        circleP9 = new EllipseDrawer(dash, random(515, 535), random(515, 535), BLUE, "P9", false); 
        circleP10 = new EllipseDrawer(dash, random(590, 610), 550, BLUE, "P10", false);  
        circleP11 = new EllipseDrawer(dash, random(315, 335), 675, WHITE, "P11", true);
        circleP12 = new EllipseDrawer(dash, random(225, 245), 715, WHITE, "P12", false);
        circleP13 = new EllipseDrawer(dash, random(305, 325), 750, WHITE, "P13", false);
        circleP14 = new EllipseDrawer(dash, random(405, 425), 745, WHITE, "P14", false);
        
    }

    void draw() {
        stateManager.incrementFrame();

        background(0);

        // Animate dashes with 'walking ants' effect
        dash.offset(dist);
        dist += 1;

        float faces1Progress = stateManager.getProgressOfState("FACE_1_PROGRESS");
        faces1.drawTextByLine(faces1Progress);
        if(faces1Progress > 0.0f) {
            textFont(font2, 22);
            circleP1.draw();
            rect1.draw();
        }

        float faces2Progress = stateManager.getProgressOfState("FACE_2_PROGRESS");
        faces2.drawTextByLine(faces2Progress);
        if(faces2Progress > 0.0f) {
            textFont(font2, 22);
            circleP2.draw();
            rect2.draw();

        }

        float faces3Progress = stateManager.getProgressOfState("FACE_3_PROGRESS");
        faces3.drawTextByLine(faces3Progress);
        if(faces3Progress > 0.0f) {
            textFont(font2, 22);
            circleP3.draw();
            rect3.draw();    
        }

        float faces4Progress = stateManager.getProgressOfState("FACE_4_PROGRESS");
        faces4.drawTextByLine(faces4Progress);
        if(faces4Progress > 0.0f) {
            textFont(font2, 22);
            circleP4.draw();
            rect4.draw();
        }
            
        if(faces4Progress > 0.15f) {
            circleP5.draw();
        }       
        if(faces4Progress > 0.3f) {
            circleP6.draw();
        }
        if(faces4Progress > 0.45f) {
            circleP7.draw();
        }
        if(faces4Progress > 0.6f) {
            circleP8.draw();
        } 
        if(faces4Progress > 0.75f) {
            circleP9.draw();
        } 
        if(faces4Progress > 0.9f) {
            circleP10.draw();
        }

        float faces5Progress = stateManager.getProgressOfState("FACE_5_PROGRESS");
        faces5.drawTextByLine(faces5Progress);
        if(faces5Progress > 0.0f) {
            textFont(font2, 22);
            circleP11.draw();
            rect5.draw();

        }


        float faces6Progress = stateManager.getProgressOfState("FACE_6_PROGRESS");
        faces6.drawTextByLine(faces6Progress);
        if(faces6Progress > 0.0f) {
            textFont(font2, 22);
            circleP12.draw();
            rect6.draw();

            }

        float faces7Progress = stateManager.getProgressOfState("FACE_7_PROGRESS");
        faces7.drawTextByLine(faces7Progress);
        if(faces7Progress > 0.0f) {
            textFont(font2, 22);
            circleP13.draw();
            rect7.draw();

        }

        float faces8Progress = stateManager.getProgressOfState("FACE_8_PROGRESS");
        faces8.drawTextByLine(faces8Progress);
        if(faces8Progress > 0.0f) {
            textFont(font2, 22);
            circleP14.draw();
            rect8.draw();
        }
    }

    String[] getStringSegment(String[] _toSegment, float _top, float _bottom, float _left, float _right) {    
        int startRow = int(_top * float( _toSegment.length));
        int endRow = int(_bottom * float(_toSegment.length));

        ArrayList<String> returnValue = new ArrayList<String>();

        for (int i = startRow; i < endRow; i++) {
            int startCol = int(_left * float(_toSegment[0].length()));
            int endCol = int(_right * float(_toSegment[0].length()));
            // println("getting segment: " + startCol + ", " + endCol + " of: " + _toSegment[i]);
            returnValue.add(_toSegment[i].substring(startCol, endCol));
        }
        
        String[] arrayList = new String[returnValue.size()];
        return arrayList = returnValue.toArray(arrayList);
    }
}