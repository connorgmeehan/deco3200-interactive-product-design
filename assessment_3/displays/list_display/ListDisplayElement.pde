class ListDisplayElement {
    int id = 23456789;
    String location = "rdtgvhbjknml";
    String datetime = "02-02-2019 06:11";
    int age = 26;
    String sex = "MALE";
    String emotion = "SURPRISED";
    float socialScore = 23.7;

    String[] table;

    int x, y;
    int height;
    PFont font;
    int fontSize;
    color idColor;
    color textColor;

    // Pass x/y position, width, height, PFont, fontSize
    ListDisplayElement(int _x, int _y, int _height, PFont _font, int _fontSize, color _idColor, color _textColor) {
        x = _x;
        y = _y;
        height = _height;
        font = _font;
        fontSize = _fontSize;
        idColor = _idColor;
        textColor = _textColor;

        table = loadStrings("table.txt");
    }

    void draw(int index) {
        int tableY = 50;
        fill(255);
        for (int i = 0; i < table.length; i++) {
            text(table[i], 50, tableY);
            tableY+=10;
        }

        int y = 165+index * height;
        textFont(font, fontSize);
        fill(#77E19F);
        text(id, x+18, y);
        fill(#607FED);
        text(location, x+113, y);
        text(datetime, x+230, y);
        text(age, x+375, y);
        text(sex, x+420, y);
        text(emotion, x+475, y);
        text(socialScore, x+575, y);
       
    }

    void setData(int _id, String _location, String _datetime, int _age, String _sex, String _emotion, float _socialScore) {
        id = _id;
        location = _location;
        datetime = _datetime;
        age = _age;
        sex = _sex;
        emotion = _emotion;
        socialScore = _socialScore;
    }
}