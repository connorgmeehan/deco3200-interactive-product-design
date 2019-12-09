#include "ListDisplayElement.h"

ofTrueTypeFont ListDisplayElement::_font;
ofColor ListDisplayElement::_emphasisColor = ofColor::white;
ofColor ListDisplayElement::_defaultColor = ofColor::white;
ofColor ListDisplayElement::_negativeColor = ofColor::white;
std::vector<int> ListDisplayElement::_columnOffsets;
float ListDisplayElement::_socialScoreThreshold = 70;
float ListDisplayElement::_resetTime = 0.0f;
float ListDisplayElement::_animationDuration = 3.0f;

ListDisplayElement::ListDisplayElement(int uid, std::string fakeId, int age, bool isMale, std::string emotion) :
  _uid(uid),
  _fakeId(fakeId),
  _age(ofToString(age)),
  _sex(isMale ? "MALE" : "FEMALE"),
  _emotion(emotion),
  _location("4RRH456R+HR"),
  _socialScore(ofToString(ofRandom(100.0f), 1)) {
  _dateTime = ofToString(ofGetYear()) + ofToString(ofGetMonth()) + ofToString(ofGetDay()) + " " + ofToString(ofGetHours()) + ":" + ofToString(ofGetMinutes());
}

void ListDisplayElement::update() {

}

void ListDisplayElement::draw() {
  if (ofGetElapsedTimef() > _triggerTimes[0]) {
    ofSetColor(_emphasisColor);
    _font.drawString(_fakeId, x + _columnOffsets[0], y + height/2);
  }
  if (ofGetElapsedTimef() > _triggerTimes[1]) {
    ofSetColor(_defaultColor);
    _font.drawString(_location, x + _columnOffsets[1], y + height / 2);
  }

  if (ofGetElapsedTimef() > _triggerTimes[2]) {
    _font.drawString(_dateTime, x + _columnOffsets[2], y + height / 2);
  }

  if (ofGetElapsedTimef() > _triggerTimes[3]) {
    _font.drawString(_age, x + _columnOffsets[3], y + height / 2);
  }

  if (ofGetElapsedTimef() > _triggerTimes[4]) {
    _font.drawString(_sex, x + _columnOffsets[4], y + height / 2);
  }

  if (ofGetElapsedTimef() > _triggerTimes[5]) {
    _font.drawString(_emotion, x + _columnOffsets[5], y + height / 2);
  }

  if (ofGetElapsedTimef() > _triggerTimes[6]) {
    if(ofToFloat(_socialScore) > _socialScoreThreshold) {
      ofSetColor(_emphasisColor);
    } else if(ofToFloat(_socialScore) < 100 - _socialScoreThreshold) {
      ofSetColor(_negativeColor);
    }
    _font.drawString(_socialScore, x + _columnOffsets[6], y + height / 2);
  }

  // ofDrawBitmapStringHighlight(_fakeId + ":" + _age + ":" + _sex + ":" + _emotion + ":" + ofToString(_triggerTimes[0]) + "/" + ofToString(_triggerTimes[1]) + "/" + ofToString(_triggerTimes[2]) + "/" + ofToString(_triggerTimes[3]) + "/" + ofToString(_triggerTimes[4]) + "/" + ofToString(_triggerTimes[5]) + "/" + ofToString(_triggerTimes[6]), x, y);
}

void ListDisplayElement::setFont(ofTrueTypeFont font) {
  _font = font;
}

void ListDisplayElement::setEmphasisColor(ofColor color) { _emphasisColor = color; }
void ListDisplayElement::setDefaultColor(ofColor color) { _defaultColor = color; }
void ListDisplayElement::setNegativeColor(ofColor color) { _negativeColor = color; }

void ListDisplayElement::setColumnOffsets(std::vector<int> columnOffsets) {
  _columnOffsets = columnOffsets;
}

void ListDisplayElement::setResetTime(float resetTime) {
  _resetTime = resetTime;
}

void ListDisplayElement::setAnimationDuration(float duration) {
  _animationDuration = duration;
}

void ListDisplayElement::setSocialScoreThreshold(float threshold) { _socialScoreThreshold = threshold; }

void ListDisplayElement::setFirst(bool isFirst) {
  _isFirst = isFirst;

  _triggerTimes.clear();
  for(float i = 0; i < _animationDuration; i+= _animationDuration/_columnOffsets.size()) {
    if (isFirst) {
      _triggerTimes.push_back(_resetTime + i);
    } else {
      _triggerTimes.push_back(0.0f);
    }
  }
}