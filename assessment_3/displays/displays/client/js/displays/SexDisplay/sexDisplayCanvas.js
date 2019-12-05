import BoxVisual from "../FacePointsDisplay/BoxVisual";
import FaceVisual from './FaceVisual';
import BarVisual from "./BarVisual";

let faceVisual;
const maxBarVisuals = 3;
let barVisuals = [];

export const resetDisplay = (points) => {
  faceVisual.reset(points);
  barVisuals.forEach(bv => bv.reset());
};

const sexDisplayCanvas = (p5) => {
  const canvasWidth = 1200;
  const canvasHeight = 625;
  window.p5 = p5; 

  const boxState = window.stateManager.findState('BOX');  

  const backgroundColor = '#30302F';
  const boxVisual = new BoxVisual(p5, 25, 25, 600, 600);
  faceVisual = new FaceVisual(p5, 50, 50, 550, 550);
  faceVisual.setLineColor(p5.color(111, 207, 151));
  faceVisual.setPointColor(p5.color(255));
  faceVisual.setScanColor(p5.color(150, 227, 182));

  for (let i = 0; i < maxBarVisuals; i++) {
    barVisuals.push(
      new BarVisual(p5, 650, 100 + i * 175, 500, 50)
        .setSegmentColor(p5.color('#1B3127'))
        .setBarColor(p5.color('#6FCF971'))
        .setBarLoadingColor(p5.color('#E5E5E5'))
    );
  }

  const scanState = window.stateManager.findState('SCAN').clearCallbacks().addCallback(state => {
    barVisuals.forEach((bv, i) => {
      const {timeout, duration} = state.getInterval(i, maxBarVisuals, 0.2);
      setTimeout(() => {
        bv.setState('active');
      }, timeout * 1000);

      setTimeout(() => {
        bv.setState('complete');
      }, (timeout + duration) * 1000);
    });
  });

  
  p5.setup = () => {
    p5.createCanvas(canvasWidth, canvasHeight);        
  };

  p5.draw = () => {
    p5.background(backgroundColor);
    boxVisual.setGap(1.0 - boxState.progress / 2);
    boxVisual.draw();
    faceVisual.draw();

    barVisuals.forEach(bv => bv.draw());
  };
};

export default sexDisplayCanvas;