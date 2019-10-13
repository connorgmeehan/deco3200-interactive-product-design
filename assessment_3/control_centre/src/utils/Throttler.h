#pragma once

#include "ofUtils.h"'

class Throttler {
  public:
    Throttler() {
      setRate(UINT64_MAX);
    }
    Throttler(float rateSeconds) {
      ofLog() << "Throttler::Throttler(float rateSeconds: " << rateSeconds << ");";
      setRate((uint64_t) rateSeconds * 1000);
    }
    Throttler(uint64_t rateMillis) {
      ofLog() << "Throttler::Throttler(uint64_t rateMillis: " << rateMillis << ");";
      setRate(rateMillis);
    }

    void setRate(uint64_t millis) {
      rate = millis;
      last = ofGetElapsedTimeMillis();
    }

    bool check() {
      auto cur = ofGetElapsedTimeMillis();
      if (cur > last + rate) {
        last = cur;
        return true;
      }
      return false;
    }

  private:
    uint64_t rate;
    uint64_t last;
};