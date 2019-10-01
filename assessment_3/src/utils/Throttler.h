#pragma once

#include "ofUtils.h"'

class Throttler {
  public:
    Throttler() {
      setRate(UINT64_MAX);
    }
    Throttler(float rateSeconds) {
      setRate((uint16_t) rateSeconds * 1000);
    }
    Throttler(uint64_t rateMillis) {
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