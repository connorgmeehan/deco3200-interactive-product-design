import p5 from 'p5';

import sexDisplayCanvas, {resetDisplay} from './sexDisplayCanvas';

import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';
import FakeIdDisplayer from '../components/FakeIdDisplayer';
import generateFakeData from './getFakeData';
import SexDisplayLineWriters from './SexDisplayLineWriters';

class SexDisplay extends GenericDisplay {
  type = 'sex';
  
  constructor() {
    super();
    console.log('sex display');
    console.log('face points display');
    const sexDisplay = document.getElementById(this.type);
    sexDisplay.classList.add('Display__Active');

    this.stateManager = new StateManager();
    this.stateManager.addState('DELAY', 17.75);
    this.stateManager.addState('INIT', 1.0);
    this.stateManager.addState('BOX', 0.25);
    this.stateManager.addState('INITIAL_POINTS', 1.0);
    this.stateManager.addState('TESSELATION', 1.0);
    this.stateManager.addState('SCAN', 2.0);
    this.stateManager.addState('RESULTS', 1.0);
    this.stateManager.addState('END', 1.0);
    window.stateManager = this.stateManager;
    
    const canvasContainer = document.querySelector('.SexDisplay_CanvasContainer');
    this.facePointsP5 = new p5(sexDisplayCanvas, canvasContainer);
    this.fakeIdDisplay = new FakeIdDisplayer(document.querySelector('.SexDisplay_ResultText'));
    this.lineWriters = new SexDisplayLineWriters();

    const {uid, fakeId, sex, features} = generateFakeData();
    this.reset(uid, fakeId, sex, features);
  }

  reset(uid, fakeId, sex, points) {
    
    this.stateManager.findState('INIT').clearCallbacks().addCallback(state => {
      this.lineWriters.startInitialText(state.duration);
    });
    
    this.stateManager.findState('RESULTS').clearCallbacks().addCallback(state => {
      this.fakeIdDisplay.drawUserObject(fakeId, state.duration, 6, null, null, sex);
    });
    
    resetDisplay(points);
    this.stateManager.reset();
  }
}

export default SexDisplay;
