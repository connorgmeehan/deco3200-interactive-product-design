import LineWriter from '../../helpers/Linewriter';
import typer from 'typer-js';

class EmotionLineWriters {
  constructor() {

  }

  startInitialText(duration) {
    const htmlLines = [
      `${new Date()}: Using TensorFlow backend.`
    ];
    
    this.intitialTextWriter = new LineWriter('.EmotionDisplay_InitialText', {duration}, htmlLines).start();
  }

  kill() {

  }
}

export default EmotionLineWriters;