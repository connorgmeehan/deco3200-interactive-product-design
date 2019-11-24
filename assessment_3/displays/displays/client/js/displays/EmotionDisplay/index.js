import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';
import EmotionLineWriters from './EmotionLineWriters';
import getFakeData from '../AsciiDisplay/getFakeData';
import FaceSegmentDisplay from './FaceSegmentDisplay';

class EmotionDisplay extends GenericDisplay {
  type = 'emotion';

  maxSegments = 8;
  segments = [];

  constructor() {
    super();
    console.log('emotion display');
    const demographic = document.getElementById('emotion');
    demographic.classList.add('Display__Active');

    // Initialise class properties
    this.lineWriters = new EmotionLineWriters();
    this.segmentsContainer = document.querySelector('.EmotionDisplay_SegmentBlock');

    // Intitialise states
    this.stateManager = new StateManager();
    this.stateManager.addState('INITIAL_TEXT', 1.0);
    this.stateManager.addState('FEATURES_DISPLAY', 2.0);
    this.stateManager.addState('END', 1.0);

    // Reset
    const {uid, fakeId, faceString, emotion} = getFakeData();
    this.reset(uid, fakeId, faceString, emotion);
  }

  reset(uid, fakeId, faceString, emotion) {
    // Cleanup previous animation
    this.lineWriters.killAll();
    this.segments.forEach(segment => segment.kill());
    this.segments = [];

    // Set data
    this.uid = uid;
    this.fakeId = fakeId;
    this.faceString = faceString;
    this.emotion = emotion;

    // Initialise on state change behaviour
    this.stateManager.findState('INITIAL_TEXT').clearCallbacks().addCallback(state => {
      this.lineWriters.startInitialText(state.duration, fakeId);
    });
    
    this.stateManager.findState('FEATURES_DISPLAY').clearCallbacks().addCallback(state => {
      const individualDuration = state.duration / this.maxSegments; 
      for (let i = 0; i < this.maxSegments; i++) {
        const faceSegment = new FaceSegmentDisplay(this.segmentsContainer, faceString, i, 25, 13);
        faceSegment.startDrawAfter(individualDuration, i * individualDuration);
        this.segments.push(faceSegment);
      }
    });

    // Reset state manager
    this.stateManager.reset();
  }

  resetImage(uid, imageData) {
    if (this.uid == uid) {
      this.imageData = imageData;
    }
  }
}

export default EmotionDisplay;
