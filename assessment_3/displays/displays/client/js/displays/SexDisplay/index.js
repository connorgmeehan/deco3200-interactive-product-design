import p5 from 'p5';

import sexDisplayCanvas from './sexDisplayCanvas';

class SexDisplay {
  constructor() {
    console.log('sex display');

    const facePoints = document.getElementById('sex');
    facePoints.classList.add('Display__Active');

    this.facePointsP5 = new p5(sexDisplayCanvas, facePoints);

  }
}

export default SexDisplay;
