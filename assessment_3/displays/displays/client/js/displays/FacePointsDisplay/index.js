import p5 from 'p5';

import facePointsCanvas from './facePointsCanvas';

import GenericDisplay from '../GenericDisplay';

class FacePointsDisplay extends GenericDisplay {
  type = 'face-points';
  constructor() {
    super();
    console.log('face points display');
    const facePoints = document.getElementById(this.type);
    facePoints.classList.add('Display__Active');

    this.facePointsP5 = new p5(facePointsCanvas, facePoints);
  }

  reset(...args) {
    console.log(args);
  }
}

export default FacePointsDisplay;