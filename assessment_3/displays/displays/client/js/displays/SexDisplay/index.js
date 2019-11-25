import p5 from 'p5';

import sexDisplayCanvas from './sexDisplayCanvas';

import GenericDisplay from '../GenericDisplay';

class SexDisplay extends GenericDisplay {
  type = 'SEX';
  
  constructor() {
    super();
    console.log('sex display');
    console.log('face points display');
    const sex = document.getElementById('sex');
    sex.classList.add('Display__Active');
    this.facePointsP5 = new p5(sexDisplayCanvas, sex);
  }

  reset() {

  }
}

export default SexDisplay;
