import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';
import getFakeData from './getFakeData';
import {
  startInitialText,
  startMainFaceText,
  startSubFaceText,
} from './textWriters';

class AsciiDisplay extends GenericDisplay {
  type = 'ascii';

  uid = 0;
  fakeId = '';
  faceString = '';
  secondaryFaces = [];
  maxFaces = 8;
  
  lineWriters = [];

  constructor() {
    super();
    console.log('ascii display');
    const facePoints = document.getElementById('ascii');
    facePoints.classList.add('Display__Active');

    this.stateManager = new StateManager();
    this.stateManager.addState('INITIAL_TEXT', 1.0).addCallback(state => {
      this.lineWriters.push(startInitialText(state.duration));
    });
    this.stateManager.addState('MAIN_FACE', 3.0);
    this.stateManager.addState('SUB_FACES', 3.0);
    const {uid, fakeId, faceString} = getFakeData();
    console.log(uid, fakeId, faceString);
    for (let i = 0; i < this.maxFaces; i++) {
      this.reset(uid, fakeId, faceString);
    }
    this.stateManager.createDebugElement();
  }

  reset(uid, fakeId, faceString) {
    console.trace();
    console.log(`AsciiDisplay.reset( uid: ${uid}, fakeId: ${fakeId}, faceString.length: ${faceString.length})`);
    this.lineWriters.forEach(lw => lw.kill());
    
    this.uid = uid;
    this.fakeId = fakeId;
    this.faceString = faceString;
    if (this.secondaryFaces.length > this.maxFaces) {
      this.secondaryFaces.pop();
    }
    this.secondaryFaces.push(faceString);

    this.stateManager.findState('MAIN_FACE').clearCallbacks().addCallback(state => {
      this.lineWriters.push(startMainFaceText(state.duration, faceString));
    });

    this.stateManager.findState('SUB_FACES').clearCallbacks().addCallback(state => {
      const {duration} = state;
      const individualDuration = duration / this.secondaryFaces.length; 
      const secondaryFaceContainers = document.querySelectorAll('.AsciiDisplay_SmallFace');
      this.secondaryFaces.forEach((faceArray, i) => {
        setTimeout(() => {
          console.log(`Starting subface ${i}`);
          this.lineWriters.push(startSubFaceText(secondaryFaceContainers[i], faceArray, individualDuration));
        }, i * individualDuration);
      });
    });

    this.stateManager.reset();
  }
}

export default AsciiDisplay;
