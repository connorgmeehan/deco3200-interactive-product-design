import {Vector} from 'p5';

import BoxVisual from './BoxVisual';
import FaceVisual from './FaceVisual';
import ScanLine from './ScanLine';

let age;
let features = [];
let faceVisual;

export /**
 * Resets data required for display
 * @param {Array<Array<Number>>} features
 */
const reset = (featuresArray, userAge) => {
  age = userAge;
  features = featuresArray.map(line => line.map(vec => new Vector().set(vec[0], vec[1])));
  faceVisual.reset(features);
};

const sketch = (p5) => {
    
  const canvasWidth = 575;
  const canvasHeight = 575;
    
  window.p5 = p5; 
  
  const boxVisual = new BoxVisual(p5, 50, 50, 475, 475);
  faceVisual = new FaceVisual(p5, 100, 100, 375, 375);
  const scanLine = new ScanLine(p5, 51, 51, 473, 100, 473);
  const color = p5.color(0, 41, 243);
  scanLine.setColor(color);

  boxVisual.setGap(0.5);
  const boxState = window.stateManager.findState('BOX');
  const scanState = window.stateManager.findState('PROCESSING');

  const backgroundColor = '#30302F';
    
  p5.setup = () => {
    p5.createCanvas(canvasWidth, canvasHeight);    

    faceVisual.reset(features);
  };
    
  p5.draw = () => {
    p5.background(backgroundColor);
    
    boxVisual.setGap(1.0 - boxState.progress / 2);
    boxVisual.draw();
    faceVisual.draw();

    if (scanState.started && !scanState.ended) {
      scanLine.setTheta(scanState.progress * Math.PI);
      scanLine.draw();
    }

  };
};

export default sketch;