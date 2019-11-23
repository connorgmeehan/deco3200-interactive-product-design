import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';
import getFakeData from './getFakeData';
import AsciiLineWriters from './AsciiLineWriters';
import {shuffle} from '../../helpers/utils';

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
    this.asciiLineWriters = new AsciiLineWriters();

    this.stateManager = new StateManager();
    this.stateManager.addState('INITIAL_TEXT', 1.0).addCallback(state => {
      this.asciiLineWriters.startInitialText(state.duration);
    });
    this.stateManager.addState('MAIN_FACE', 1.0);
    this.stateManager.addState('SUB_FACES', 2.0);
    this.stateManager.addState('SCAN_MAIN', 0.5);
    this.stateManager.addState('SCAN_SUB', 1.0);
    this.stateManager.addState('DETECTED', 1.0);
    this.stateManager.addState('RETURN_DATA', 1.0);
    this.stateManager.addState('END', 0.0);

    const {uid, fakeId, faceString} = getFakeData();
    console.log(uid, fakeId, faceString);
    for (let i = 0; i < this.maxFaces; i++) {
      this.reset(uid, fakeId, faceString);
    }
    this.stateManager.createDebugElement();
  }

  reset(uid, fakeId, faceString) {
    console.log(`AsciiDisplay.reset( uid: ${uid}, fakeId: ${fakeId}, faceString.length: ${faceString.length})`);    
    this.asciiLineWriters.killAll();

    this.uid = uid;
    this.fakeId = fakeId;
    this.faceString = faceString;
    this.secondaryFaces.push(faceString);
    if (this.secondaryFaces.length > this.maxFaces) {
      this.secondaryFaces.splice(0, 1);
    }

    this.stateManager.findState('MAIN_FACE').clearCallbacks().addCallback(state => {
      this.asciiLineWriters.startMainFaceText(state.duration, faceString);
    });

    this.stateManager.findState('SUB_FACES').clearCallbacks().addCallback(state => {
      const {duration} = state;
      const individualDuration = duration / this.secondaryFaces.length; 
      const secondaryFaceContainers = document.querySelectorAll('.AsciiDisplay_SmallFace');
      console.log(duration, individualDuration);
      this.secondaryFaces.forEach((faceArray, i) => {
        setTimeout(() => {
          console.log(`Starting subface ${i} timeout = ${i * individualDuration}`);
          this.asciiLineWriters.startSubFaceText(secondaryFaceContainers[i], faceArray, individualDuration);
        }, i * individualDuration * 1000);
      });
    });

    this.stateManager.findState('SCAN_MAIN').clearCallbacks().addCallback(state => {
      this.asciiLineWriters.mainFaceLineWriter.applyClass('u--color-green', state.duration);
    });

    this.stateManager.findState('SCAN_SUB').clearCallbacks().addCallback(state => {
      this.asciiLineWriters.mainFaceLineWriter.removeClass('u--color-green');

      const {duration} = state;
      const individualDuration = duration / this.asciiLineWriters.subFaceLineWriters.length; 
      shuffle(this.asciiLineWriters.subFaceLineWriters).forEach((lineWriter, i) => {
        setTimeout(() => {
          console.log(`Starting subface ${i} applyClass timeout = ${i * individualDuration}`);
          lineWriter.applyClass('u--color-white', individualDuration);
        }, i * individualDuration * 1000);

        setTimeout(() => {
          lineWriter.removeClass('u--color-white', individualDuration);
        }, (i+1) * individualDuration * 1000);
      });
    });
    this.stateManager.findState('DETECTED').clearCallbacks().addCallback(state => {
      this.asciiLineWriters.startDetectedText(this.fakeId, state.duration);
    });
    this.stateManager.findState('RETURN_DATA').clearCallbacks().addCallback(state => {
      this.asciiLineWriters.startReturningDataText(state.duration);
    });

    this.stateManager.reset();
  }
}

export default AsciiDisplay;
