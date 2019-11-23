import { splitSubstring } from './helpers/utils';

const OSC = require('osc/dist/osc-browser');

function startOSC(display) {
  const oscPort = new OSC.WebSocketPort({
    url: 'ws://localhost:3000', // URL to your Web Socket server.
    metadata: true
  });
  console.log(`OSC client socket connection intialising on ${oscPort.options.url}...`);
  console.log(oscPort);

  oscPort.on('message', function(oscMsg) {
    switch (oscMsg.address) {
    case '/display/face':
      if (display.type == 'face-points') {
        display.reset(oscMsg.args);
      }
      break;
    case '/display/gender':
      if (display.type == 'demographic') {
        display.reset(oscMsg.args);
      }
      break;
    case '/display/ascii':
      if (display.type == 'ascii') {
        console.log('/display/ascii recieved...');
        const uid = oscMsg.args[0].value;
        const fakeId = oscMsg.args[1].value;
        const faceLines = splitSubstring(oscMsg.args[2].value, 51);
        display.reset(uid, fakeId, faceLines);
      }
    case '/display/img':
      break;

    case '/display/emotion':
      if (display.type == 'emotion') {
        display.reset(oscMsg.args);
      }
      break;
    default:
      console.warn(`Recieved OSC message at address ${oscMsg.address} that could not be routed to a display`);
      break;
    }
  });
  oscPort.on('ready', function() {
    console.log('OSC client socket connection initialised');
  });
  oscPort.open(); 
}

export default startOSC;
