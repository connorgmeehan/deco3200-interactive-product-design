import p5 from 'p5';
import emotionCanvas from './emotionCanvas';

import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';
import EmotionLineWriters from './EmotionLineWriters';
import getFakeData from '../AsciiDisplay/getFakeData';
import FaceSegmentDisplay from './FaceSegmentDisplay';
import FakeIdDisplayer from '../components/FakeIdDisplayer';

class EmotionDisplay extends GenericDisplay {
  type = 'emotion';

  maxSegments = 8;
  segments = [];

  constructor() {
    super();
    console.log('emotion display');
    const emotionDisplayElement = document.getElementById('emotion');
    emotionDisplayElement.classList.add('Display__Active');
    const canvasContainer = document.querySelector('.EmotionDisplay_Canvas');

    // Intitialise states
    this.stateManager = new StateManager();
    window.stateManager = this.stateManager;
    this.stateManager.addState('INITIAL_TEXT', 2.0);
    this.stateManager.addState('FEATURES_DISPLAY', 2.0);
    this.stateManager.addState('SCAN', 3.0);
    this.stateManager.addState('RESULTS', 2.0);
    this.stateManager.addState('ID', 2.0);
    this.stateManager.addState('END', 5.0);
    
    // Initialise class properties
    this.emotionCanvas = new p5(emotionCanvas, canvasContainer);
    this.lineWriters = new EmotionLineWriters();
    this.segmentsContainer = document.querySelector('.EmotionDisplay_SegmentBlock');
    this.fakeIdDisplayer = new FakeIdDisplayer(document.querySelector('.EmotionDisplay_IdText'));

    // Reset
    setTimeout(() => {
      const {uid, fakeId, faceString, emotion} = getFakeData();
      this.reset(uid, fakeId, faceString, emotion);
    }, 1000);
  }

  reset(uid, fakeId, faceString, emotion) {
    // Cleanup previous animation
    this.lineWriters.killAll();
    this.segments.forEach(segment => segment.kill());
    this.segments = [];
    this.segmentsContainer.innerHTML = '';
    this.fakeIdDisplayer.clear();

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

    this.stateManager.findState('SCAN').clearCallbacks().addCallback(state => {
      this.segments.forEach((segment, i) => {
        const {timeout, duration} = state.getInterval(i, this.maxSegments, 0.1);
        setTimeout(() => {
          segment.startScanAnimation(duration);
        }, timeout * 1000);
      });
    });

    this.stateManager.findState('RESULTS').clearCallbacks().addCallback(state => {
      this.lineWriters.startResultText(state.duration, emotion);
    });

    this.stateManager.findState('ID').clearCallbacks().addCallback(state => {
      this.fakeIdDisplayer.drawUserObject(this.fakeId, state.duration, 10, emotion);
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
