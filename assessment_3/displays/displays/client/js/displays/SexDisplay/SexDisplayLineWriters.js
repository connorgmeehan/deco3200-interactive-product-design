import LineWriter from '../components/Linewriter';
import {getStringArrayTotalLength} from '../../helpers/utils';
import typer from 'typer-js';

class SexDisplayLineWriters {
  constructor() {

  }

  startInitialText(duration) {
    const htmlLines = [
      `* ${new Date()}`,
      '<span class="u--invisible">space</span>',
      '* Initialising sex predidiction...',
      `* Analysing figure `
    ];
    const charDuration = duration / (getStringArrayTotalLength(htmlLines));
    this.intitialTextTyper = typer('.SexDisplay_InitialText', {speed: charDuration})
      .line(htmlLines[0]).pause(300)
      .line(htmlLines[1]).pause(300)
      .line(htmlLines[2]).pause(300)
      .line(htmlLines[3]).pause(300)
      .line(htmlLines[4]).pause(300).continue('.')
      .pause(300).continue('.')
      .pause(300).continue('.');
  }

  startResultText() {

  }
}

export default SexDisplayLineWriters;