#pragma once
#include "ofMain.h"

class ListDisplayElement : public ofRectangle {
  public:
    ListDisplayElement(int uid, std::string fakeId, int age, bool isMale, std::string emotion);

    void update();
    void draw();

    static void setFont(ofTrueTypeFont font);
    static void setEmphasisColor(ofColor color);
    static void setDefaultColor(ofColor color);
    static void setNegativeColor(ofColor color);

    static void setColumnOffsets(std::vector<int> columnOffsets);
    static void setSocialScoreThreshold(float threshold);
    static void setResetTime(float resetTime);
    static void setAnimationDuration(float duration);

    void setFirst(bool isFirst);
  private:
    static ofTrueTypeFont _font;
    static ofColor _emphasisColor, _defaultColor, _negativeColor;
    static std::vector<int> _columnOffsets;
    static float _socialScoreThreshold;
    static float _resetTime;
    static float _animationDuration;
    bool _isFirst;

    int _uid;
    std::string _fakeId, _age, _sex, _emotion, _location, _dateTime, _socialScore;
    std::vector<float> _triggerTimes;
};