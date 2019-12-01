import p5 from 'p5';

import FacePointsLineWriters from './FacePointsLineWriters';
import generateFakeData from './generateFakeData';
import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';

import facePointsCanvas from './facePointsCanvas';
import {reset} from './facePointsCanvas';
import FakeIdDisplayer from '../components/FakeIdDisplayer';

class FacePointsDisplay extends GenericDisplay {
  type = 'face-points';
  constructor() {
    super();
    console.log('face points display');
    const facePoints = document.getElementById(this.type);
    facePoints.classList.add('Display__Active');

    this.stateManager = new StateManager();
    this.stateManager.addState('INIT', 2);
    this.stateManager.addState('BOX', 0.25);
    this.stateManager.addState('FACE_LINES', 1);
    this.stateManager.addState('FACE_POINTS', 1);
    this.stateManager.addState('PROCESSING', 2);
    this.stateManager.addState('RETURN', 2);
    this.stateManager.addState('END', 2);
    window.stateManager = this.stateManager;

    this.lineWriters = new FacePointsLineWriters();
    const canvasContainer = document.querySelector('.FacePointsDisplay_CanvasContainer');
    this.facePointsP5 = new p5(facePointsCanvas, canvasContainer);
    this.fakeIdDisplayer = new FakeIdDisplayer(document.querySelector('.FacePointsDisplay_Results'));
    
    const {uid, fakeId, features, age} = generateFakeData();
    this.reset(uid, fakeId, features, age);
  }

  reset(uid, fakeId, features, age) {
    reset(features, age);

    // Initialise on state change behaviour
    this.stateManager.findState('INIT').clearCallbacks().addCallback(state => {
      this.lineWriters.startInitialText(state.duration, fakeId);
    });

    this.stateManager.findState('PROCESSING').clearCallbacks().addCallback(state => {
      this.lineWriters.startResultText(state.duration);
    });

    this.stateManager.findState('RETURN').clearCallbacks().addCallback(state => {
      this.fakeIdDisplayer.drawUserObject(fakeId, state.duration, 6, null, age, null);
    });

    this.stateManager.reset();
  }
}

export default FacePointsDisplay;