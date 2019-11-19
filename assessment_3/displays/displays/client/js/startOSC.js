const OSC = require('osc/dist/osc-browser');

function startOSC(displayCallback) {
  const oscPort = new OSC.WebSocketPort({
    url: 'ws://localhost:3000', // URL to your Web Socket server.
    metadata: true
  });
  console.log(`OSC client socket connection intialising on ${oscPort.options.url}...`);
  console.log(oscPort);

  oscPort.on('message', function(oscMsg) {
    console.log('An OSC message just arrived!', oscMsg);
    displayCallback(oscMsg.args);
  });
  oscPort.on('ready', function() {
    console.log('OSC client socket connection initialised');
  });
  oscPort.open(); 
}

export default startOSC;
