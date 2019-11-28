import EmotionPoint from './EmotionPoint';
import {signedRandom} from '../../helpers/utils';

const pointsCount = 14;

const generatePointData = () => [
  // left eye
  { x: 200 + signedRandom(15), y: 170 + signedRandom(15), color: '#0029F3', drawTop: true },
  { x: 200 + signedRandom(15), y: 270 + signedRandom(15), color: '#0029F3', drawTop: false },
  { x: 300 + signedRandom(15), y: 280 + signedRandom(15), color: '#0029F3', drawTop: false },
  { x: 375 + signedRandom(15), y: 300 + signedRandom(15), color: '#0029F3', drawTop: false },
  { x: 375 + signedRandom(15), y: 170 + signedRandom(15), color: '#0029F3', drawTop: true },
  // right eye
  { x: 525 + signedRandom(15), y: 190 + signedRandom(15), color: '#0029F3', drawTop: true },
  { x: 525 + signedRandom(15), y: 280 + signedRandom(15), color: '#0029F3', drawTop: false },
  { x: 600 + signedRandom(15), y: 290 + signedRandom(15), color: '#0029F3', drawTop: false },
  { x: 700 + signedRandom(15), y: 300 + signedRandom(15), color: '#0029F3', drawTop: false },
  { x: 700 + signedRandom(15), y: 210 + signedRandom(15), color: '#0029F3', drawTop: true },
  // nose
  { x: 400 + signedRandom(15), y: 475 + signedRandom(15), color: '#F7EC6D', drawTop: true },
  // mouth
  { x: 300 + signedRandom(15), y: 590 + signedRandom(15), color: '#E5E5E5', drawTop: false },
  { x: 400 + signedRandom(15), y: 620 + signedRandom(15), color: '#E5E5E5', drawTop: false },
  { x: 525 + signedRandom(15), y: 620 + signedRandom(15), color: '#E5E5E5', drawTop: false },
];

let points = [];
const sketchConstructor = (p5) => {
  const stateManager = window.stateManager;
  let font;
  let width, height;
  const backgroundColor = '#30302F';

  const reset = () => {
    console.log('EMOTION CANVAS RESET');
    points = [];

    const pointData = generatePointData();

    stateManager.findState('FEATURES_DISPLAY').addCallback(state => {
      const individualDuration = state.duration / pointsCount;
      for (let i = 0; i < pointsCount; i++) {
        const p = pointData[i];
        setTimeout(() => {
          const newEmotionPoint = new EmotionPoint(p5, p.x, p.y, 50, p.color);
          newEmotionPoint.setFont(font);
          newEmotionPoint.setText(i, p.drawTop);
          points.push(newEmotionPoint);
        }, i * individualDuration * 1000);
      }
    });
  };

  p5.setup = () => {
    console.log('Emotion Canvas Setup');
    width = 1000;
    height = 800;
    p5.createCanvas(width, height);
    stateManager.addResetCallback(reset);
    reset();
    font = p5.loadFont('/fonts/IBMPlexMono-SemiBold.ttf');
  };

  p5.draw = () => {
    p5.background(backgroundColor);

    points.forEach(p => {
      p.draw();
    });
  };  
};

export default sketchConstructor;