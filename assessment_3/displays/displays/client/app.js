'use strict';

import FacePoints from './js/displays/FacePointsDisplay';
import SexDisplay from './js/displays/SexDisplay';

// Use webpack normally
import './styles/main.scss';
import startOSC from './js/startOSC';

;(function() {
  console.log('I am the main application entrypoint');
  const container = document.getElementById('root');
  container.innerHTML = 'Hello World';

  console.log(`loading ${window.location.pathname}`);
  switch (window.location.pathname) {
  case '/face_points.html':
    window.currentDisplay = new FacePoints();
    break;
  case '/sex.html':
    window.currentDisplay = new SexDisplay();
    break;
  default:
    break;
  }

  startOSC();
})();
