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

  constructor() {
    super();
    console.log('ascii display');
    const facePoints = document.getElementById('ascii');
    facePoints.classList.add('Display__Active');

    this.stateManager = new StateManager();
    this.stateManager.addState('INITIAL_TEXT', 1.0).addCallback(() => {
      startInitialText(1.0);
    });
    this.stateManager.addState('MAIN_FACE', 1.0).addCallback(state => {
      startMainFaceText(state.duration, this.faceString);
    });
    this.stateManager.addState('SUB_FACES', 1.0);

    this.reset(getFakeData());
  }

  reset(uid, fakeId, faceString) {
    this.uid = uid;
    this.fakeId = fakeId;
    this.faceString = faceString;
    this.stateManager.reset();
  }
}

export default AsciiDisplay;
