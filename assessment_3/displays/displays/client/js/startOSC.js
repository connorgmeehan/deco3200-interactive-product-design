import { splitSubstring, escapeHtml } from './helpers/utils';

const OSC = require('osc/dist/osc-browser');

function startOSC(display) {
  const oscPort = new OSC.WebSocketPort({
    url: 'ws://192.168.0.70:8080', // URL to your Web Socket server.
    metadata: true
  });
  console.log(`OSC client socket connection intialising on ${oscPort.options.url}...`);
  console.log(oscPort);

  oscPort.on('message', function(oscMsg) {
    switch (oscMsg.address) {
    case '/display/face':
      if (display.type == 'face-points') {
        const uid = oscMsg.args[0].value;
        const fakeId = oscMsg.args[1].value;
        const age = oscMsg.args[2].value;
        let encodedPoints = [];
        for (let i = 3; i < oscMsg.args.length; i++) {
          const featurePoints = oscMsg.args[i].value.split(",");
          const formattedFeaturePoints = [];
          for (let j = 0; j < featurePoints.length; j+=2) {
            formattedFeaturePoints.push([featurePoints[j], featurePoints[j+1]]);
          }
          encodedPoints.push(formattedFeaturePoints);
        }
        display.reset(uid, fakeId, encodedPoints, age);
      }
      break;
    case '/display/gender':
      if (display.type == 'sex') {
        const uid = oscMsg.args[0].value;
        const fakeId = oscMsg.args[1].value;
        const sex = oscMsg.args[2].value;
        let encodedPoints = [];
        for (let i = 3; i < oscMsg.args.length; i++) {
          const featurePoints = oscMsg.args[i].value.split(",");
          const formattedFeaturePoints = [];
          for (let j = 0; j < featurePoints.length; j+=2) {
            formattedFeaturePoints.push([featurePoints[j], featurePoints[j+1]]);
          }
          encodedPoints.push(formattedFeaturePoints);
        }
        console.log('DISPLAY SEX', uid, fakeId, sex, encodedPoints);
        display.reset(uid, fakeId, sex, encodedPoints);
      }
      break;
    case '/display/ascii':
      if (display.type == 'ascii') {
        console.log('/display/ascii recieved...');
        const uid = oscMsg.args[0].value;
        const fakeId = oscMsg.args[1].value;
        let faceLines = splitSubstring(oscMsg.args[2].value, 51);
        faceLines = faceLines.map(line => escapeHtml(line));
        display.reset(uid, fakeId, faceLines);
      }
    case '/display/img':
      if (display.type == 'emotion') {
        console.log(oscMsg.args);
        display.resetImage(oscMsg.args);
      }
      break;

    case '/display/emotion':
      if (display.type == 'emotion') {
        const uid = oscMsg.args[0].value;
        const fakeId = oscMsg.args[1].value;
        const emotion = oscMsg.args[2].value;
        const ascii = oscMsg.args[3].value.split(/\r?\n/);
        display.reset(uid, fakeId, ascii, emotion);
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
