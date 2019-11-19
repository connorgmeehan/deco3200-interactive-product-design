import osc from 'osc';
import WebSocket from 'ws';

const websocketApp = (server) => {
  // Listen for Web Socket requests.
  var wss = new WebSocket.Server({
    server: server
  });

    // Listen for Web Socket connections.
  wss.on("connection", function(socket) {
    var socketPort = new osc.WebSocketPort({
      socket: socket,
      metadata: true
    });

    socketPort.on("message", function(oscMsg) {
      console.log("An OSC Message was received!", oscMsg);
    });
  });

};

export default websocketApp;