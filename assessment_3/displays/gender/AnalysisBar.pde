class AnalysisBar {
    int x, y;
    int barWidth = 0;
    color c;
    color barRunning = 255;
    color barComplete = #6FCF97;
    String label;
    PFont font;
    boolean randomizeBar;

    AnalysisBar(int _x, int _y, color _c, String _label, PFont _font) {
        x = _x;
        y = _y;
        c = _c;
        label = _label;
        font = _font;
    }

    void draw() {

        fill(255);
        textFont(font, 16);
        text(label, x, y-20);
        for (int i = 0; i < 16; i++) {
            fill(c);    
            rect(x + i * 20, y, 10, 30);
        }

        if(randomizeBar) {
            float time = float(millis())/500.0f;
            barWidth = (int) (noise(time) * 310.0f);
            fill(barRunning);
            label = str(map(barWidth, 0, 310, 0, 100));
        } else {
            fill(barComplete);
        }
        rect(x, y, barWidth, 30);
    }

    void setRandomizeBar(boolean _randomizeBar) {
        randomizeBar = _randomizeBar;
    }



}