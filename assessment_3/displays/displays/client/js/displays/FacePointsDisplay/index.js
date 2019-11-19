import p5 from 'p5';

import facePointsCanvas from './facePointsCanvas';

export default class FacePointsDisplay {
  constructor() {
    console.log('face points display');
    const facePoints = document.getElementById('face-points');
    facePoints.classList.add('Display__Active');

    this.facePointsP5 = new p5(facePointsCanvas, facePoints);
  }
}
