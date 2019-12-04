import BoxVisual from "../FacePointsDisplay/BoxVisual";
import FaceVisual from './FaceVisual';

let faceVisual;

export const resetDisplay = (points) => {
  faceVisual.reset(points);
};

const sexDisplayCanvas = (p5) => {
  const canvasWidth = 800;
  const canvasHeight = 800;
  window.p5 = p5; 

  const backgroundColor = '#30302F';
  const boxVisual = new BoxVisual(p5, 50, 50, 700, 700);
  faceVisual = new FaceVisual(p5, 100, 100, 600, 600);

  const boxState = window.stateManager.findState('BOX');  
  
  p5.setup = () => {
    p5.createCanvas(canvasWidth, canvasHeight);        
  };

  p5.draw = () => {
    p5.background(backgroundColor);
    boxVisual.setGap(1.0 - boxState.progress / 2);
    boxVisual.draw();
    faceVisual.draw();
  };
};

export default sexDisplayCanvas;