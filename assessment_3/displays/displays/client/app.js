'use strict';

import FacePoints from './js/displays/FacePointsDisplay';
import SexDisplay from './js/displays/SexDisplay';

// Use webpack normally
import './styles/main.scss';
import startOSC from './js/startOSC';

;(function() {
  console.log('I am the main application entrypoint');

  console.log(`loading ${window.location.search}`);
  switch (window.location.search) {
  case '?face_points=active':
    window.currentDisplay = new FacePoints();
    break;
  case '?sex=active':
    window.currentDisplay = new SexDisplay();
    break;
  case '?age=active':
  case '?ascii=active':
  default:
    const menuElement = document.getElementById('menu');
    menuElement.classList.add('Menu__Active');
    break;
  }

  startOSC(window.currentDisplay.reset);
})();
