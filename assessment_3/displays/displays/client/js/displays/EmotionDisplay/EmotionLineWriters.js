import LineWriter from '../components/Linewriter';
import typer from 'typer-js';
import { getStringArrayTotalLength } from '../../helpers/utils';

class EmotionLineWriters {
  constructor() {

  }

  startInitialText(duration, fakeId) {
    console.log('Starting initial text, ', duration, ', ', fakeId);
    const htmlLines = [
      `* ${new Date()}`,
      '* Using TensorFlow backend.',
      '<span class="u--invisible">space</span>',
      '* Initialising emotion recognition...',
      `* Analysing figure [<span class="u--color-green">${fakeId}</span>]`
    ];
    const charDuration = duration / (getStringArrayTotalLength(htmlLines));
    this.intitialTextTyper = typer('.EmotionDisplay_InitialText', {speed: charDuration})
      .line(htmlLines[0]).pause(300)
      .line(htmlLines[1]).pause(300)
      .line(htmlLines[2]).pause(300)
      .line(htmlLines[3]).pause(300)
      .line(htmlLines[4]).pause(300)
      .pause(300).continue('.')
      .pause(300).continue('.')
      .pause(300).continue('.');
  }

  startResultText(duration) {
    const htmlLines = [
      '* Complete...',
      '* Printing emotion prediction results...',
    ];
    
    const charDuration = duration / getStringArrayTotalLength(htmlLines);
    this.resultTyper = typer('.EmotionDisplay_ResultText', {speed: charDuration})
      .line(htmlLines[0])
      .line(htmlLines[1])
  }

  killAll() {
    this.intitialTextWriter && this.intitialTextWriter.kill();
    document.querySelector('.EmotionDisplay_InitialText').innerHTML = '';
  }
}

export default EmotionLineWriters;