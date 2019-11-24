import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';
import EmotionLineWriters from './EmotionLineWriters';

class EmotionDisplay extends GenericDisplay {
  type = 'emotion';
  constructor() {
    super();
    console.log('emotion display');
    const demographic = document.getElementById('emotion');
    demographic.classList.add('Display__Active');

    this.lineWriters = new EmotionLineWriters();

    this.stateManager = new StateManager();
    this.stateManager.addState('INITIAL_TEXT', 1.0);
  }

  reset(...args) {
    console.log(args);
    this.stateManager.findState('INITIAL_TEXT').clearCallbacks().addCallback(() => {
      this.lineWriters.startInitialText();
    });
  }
}

export default EmotionDisplay;
