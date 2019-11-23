import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';
import startInitialText from './startInitialText';
import startMainFaceText from './startMainFaceText';
import getFakeData from './getFakeData';

class AsciiDisplay extends GenericDisplay {
  type = 'ascii';

  uid = 0;
  fakeId = '';
  faceString = '';
  secondaryFaces = [];
  maxFaces = 8;

  constructor() {
    super();
    console.log('ascii display');
    const facePoints = document.getElementById('ascii');
    facePoints.classList.add('Display__Active');

    this.stateManager = new StateManager();
    this.stateManager.addState('INITIAL_TEXT', 1.0).addCallback(state => {
      startInitialText(state.duration);
    });
    this.stateManager.addState('MAIN_FACE', 3.0);
    this.stateManager.addState('SUB_FACES', 3.0);
    const {uid, fakeId, faceString} = getFakeData();
    console.log(uid, fakeId, faceString);
    this.reset(uid, fakeId, faceString);
    this.stateManager.createDebugElement();
  }

  reset(uid, fakeId, faceString) {
    console.trace();
    console.log(`AsciiDisplay.reset( uid: ${uid}, fakeId: ${fakeId}, faceString.length: ${faceString.length})`);
    this.uid = uid;
    this.fakeId = fakeId;
    this.faceString = faceString;
    if (this.secondaryFaces.length > this.maxFaces) {
      this.secondaryFaces.pop();
    }
    this.secondaryFaces.push(faceString);

    this.stateManager.findState('MAIN_FACE').clearCallbacks().addCallback(state => {
      startMainFaceText(state.duration, faceString);
    });

    this.stateManager.reset();
  }
}

export default AsciiDisplay;
