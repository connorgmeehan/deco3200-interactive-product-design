import LineWriter from '../../helpers/Linewriter';
import typer from 'typer-js';

class AsciiLineWriters {
  initialTextLineWriter;
  mainFaceLineWriter;
  subFaceLineWriters = [];

  constructor() {

  }

  startMainFaceText = (duration, mainFaceString) => {
    const lineWriter = new LineWriter('.AsciiDisplay_MainFace', {duration});
    mainFaceString.forEach(line => {
      lineWriter.line(line);
    });
    lineWriter.start();
    this.mainFaceLineWriter = lineWriter;
  };
  
  startSubFaceText = (element, lines, duration) => {
    const lineWriter = new LineWriter(element, {duration}, lines);
    lineWriter.start();
    this.subFaceLineWriters.push(lineWriter);
  };
  
  startInitialText = (duration) => {
    const displayText = [
      'sudo /etc/init.d/dbus restart',
      '* Starting system message bus dbus [ <span class="u--color-green">OK</span> ]',
      '* Starting network connection manager NetworkManager [ <span class="u--color-green">OK</span> ]',
      '* Starting network events dispatcher NetworkManagerDispatcher [ <span class="u--color-green">OK</span> ]',
      '* Starting System Tools Backends system-tools-backends [ <span class="u--color-green">OK</span> ]',
      '* Starting Avahi mDNS/DNS-SD Daemon avahi-daemon [<span class="u--color-red">FAIL</span>]',
      '* Starting DHCP D-Bus daemon dhcdbd [ <span class="u--color-green">OK</span> ]',
      '* Starting Hardware abstraction layer haldinvoke-rc.d: initscript hal, action "face_analysis" init ',
    ];
    const lineWriter = new LineWriter('.AsciiDisplay_InitialText', { duration }, displayText);
    lineWriter.start();
    this.initialTextLineWriter = lineWriter;
  };

  startDetectedText(fakeId, duration) {
    const displayText = [
      '* new_figure_detected:',
      `    - figure.id: <span class="u--color-green">${fakeId}</span>`,
      '    - figure.is_new: <span class="u--color-green">true</span>',
      `    - figure.confidence: <span class="u--color-green">${Math.trunc(50 + Math.random() * 50, 3)}</span>`,      
    ];

    this.detectedText = new LineWriter('.AsciiDisplay_ResultText', {duration}, displayText);
    this.detectedText.start();
  }

  startReturningDataText() {
    this.returningDataTyper = typer('.AsciiDisplay_ReturnText')
      .line('Returning result to DATABASE HOST')
      .pause(300).continue('.')
      .pause(300).continue('.')
      .pause(300).continue('.')
      .pause(500).continue(' 200 OK').pause(200)
      .line('Result complete, killing lambra function...');
  }

  killAll() {
    this.mainFaceLineWriter && this.mainFaceLineWriter.kill();
    this.initialTextLineWriter && this.initialTextLineWriter.kill();
    this.detectedText && this.detectedText.kill();
    this.returningDataTyper && this.returningDataTyper.kill();
    this.subFaceLineWriters.forEach(lw => {
      lw.kill();
    });
    document.querySelector('.AsciiDisplay_ReturnText').innerHTML = '';
  }
}


export default AsciiLineWriters;