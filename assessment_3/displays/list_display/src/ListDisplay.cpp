#pragma once

#include "ListDisplay.h"

void ListDisplay::setup() {
  _tableStrings = std::vector<std::string> {
    "+--------------+-------------+-----------------+-------+--------+-----------+-------------+",
    "| ID           | LOCATION    | DATETIME        | AGE   | SEX    | EMOTION   | SOCIALSCORE |",
    "+--------------+-------------+-----------------+-------+--------+-----------+-------------+",
  };
  _colOffsets = std::vector<int>{20, 170, 310, 490, 570, 660, 780};

  ListDisplayElement::setColumnOffsets(_colOffsets);
  ListDisplayElement::setEmphasisColor(ofColor(119, 225, 159));
  ListDisplayElement::setDefaultColor(ofColor(96, 127, 237));
  ListDisplayElement::setNegativeColor(ofColor(220, 63, 54));
  ListDisplayElement::setSocialScoreThreshold(70.0f);
  ListDisplayElement::setAnimationDuration(3.0f);
  
  _font.load("IBMPlexMono-SemiBold.ttf", 12);
  ListDisplayElement::setFont(_font);

  addNewRow(0, "ABCDEFG0123", 20, true, "HAPPY");
  addNewRow(0, "ABCDEFG0124", 20, false, "SAD");
  addNewRow(0, "ABCDEFG0125", 20, true, "HAPPY");
  addNewRow(0, "ABCDEFG0126", 20, false, "CONFUSED");
  addNewRow(0, "ABCDEFG0127", 20, true, "HAPPY");
  addNewRow(0, "ABCDEFG0128", 20, false, "SUPRISED");
  addNewRow(0, "ABCDEFG0129", 20, true, "HAPPY");
  addNewRow(0, "ABCDEFG0130", 20, false, "HAPPY");
  addNewRow(0, "ABCDEFG0131", 20, true, "HAPPY");
}

void ListDisplay::update() {

}

void ListDisplay::draw() {
  ofSetColor(ofColor::white);
  for (size_t i = 0; i < _tableStrings.size(); i++) {
    auto & s = _tableStrings[i];
    _font.drawString(s, _padding, _padding + i * 16);
  }
  
  for( auto & el : _listElements) {
    el.draw();
  }

  ofDrawBitmapString(ofToString(ofGetElapsedTimef()), ofGetMouseX(), ofGetMouseY());
}

void ListDisplay::addNewRow(int uid, std::string fakeId, int age, bool isMale, std::string emotion) {
  if (_listElements.size() > _maxListElements) {
    _listElements.erase(_listElements.begin(), _listElements.begin()+1);
  }
  auto listEl = ListDisplayElement(uid, fakeId, age, isMale, emotion);
  _listElements.push_back(listEl);

  _recalculateListElementLocations();
}

void ListDisplay::_recalculateListElementLocations() {
  ListDisplayElement::setResetTime(ofGetElapsedTimef());
  for (size_t i = 0; i < _listElements.size(); i++) {
    auto & le = _listElements[i];
    le.setFirst(i == 0);
    le.set(_padding, _padding * 2 + i * _elementSpacing, ofGetWidth() - _padding * 2, _elementSpacing);
  }
}