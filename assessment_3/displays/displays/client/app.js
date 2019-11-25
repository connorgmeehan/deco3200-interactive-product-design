'use strict';

import FacePoints from './js/displays/FacePointsDisplay';
import SexDisplay from './js/displays/SexDisplay';
import DemographicDisplay from './js/displays/EmotionDisplay';
import AsciiDisplay from './js/displays/AsciiDisplay';

// Use webpack normally
import './styles/main.scss';
import startOSC from './js/startOSC';

;(function() {
  console.log(`loading ${window.location.search}`);
  switch (window.location.search) {
  case '?face_points=active':
    window.currentDisplay = new FacePoints();
    break;
  case '?sex=active':
    window.currentDisplay = new SexDisplay();
    break;
  case '?demographic=active':
    window.currentDisplay = new DemographicDisplay();
    break;
  case '?ascii=active':
    window.currentDisplay = new AsciiDisplay();
    break;
  default:
    const menuElement = document.getElementById('menu');
    menuElement.classList.add('Menu__Active');
    break;
  }
  if (window.currentDisplay) {
    startOSC(window.currentDisplay);
  }
})();
