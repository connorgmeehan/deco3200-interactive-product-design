import GenericDisplay from '../GenericDisplay';
import StateManager from '../../StateManager';

class EmotionDisplay extends GenericDisplay {
  type = 'emotion';
  constructor() {
    super();
    console.log('emotion display');
    const demographic = document.getElementById('emotion');
    demographic.classList.add('Display__Active');

    this.stateManager = new StateManager();
    this.stateManager.addState('INITIAL_TEXT', 1.0);
  }

  reset(...args) {
    console.log(args);
  }
}

export default EmotionDisplay;
