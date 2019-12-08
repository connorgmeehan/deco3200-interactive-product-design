import osc from 'osc';
import WebSocket from 'ws';


const websocketApp = (server) => {
  const HOST = process.env.DISPLAY_HOST || "192.168.0.70";
  const PORT = process.env.DISPLAY_PORT || "8080";
  
  // Listen for Web Socket requests.
  var wss = new WebSocket.Server({
    server: server
  });

  let socketPort;
  // Listen for Web Socket connections.
  wss.on("connection", function(socket) {
    console.log(socket);
    socketPort = new osc.WebSocketPort({
      socket: socket,
      metadata: true
    });

    socketPort.on("message", function(oscMsg) {
      console.log("An OSC Message was received!", oscMsg);
    });
  });

  // Recieving OSC 
  var udpPort = new osc.UDPPort({
    localAddress: HOST,
    localPort: PORT,
    metadata: true
  });

  // Listen for incoming OSC messages.
  udpPort.on("message", function(oscMsg, timeTag, info) {
    console.log("An OSC message just arrived!", oscMsg.address, info.size);
    console.log("Remote info is: ", info);
    if (socketPort) {
      socketPort.send({
        address: oscMsg.address,
        args: oscMsg.args,
      });
    } else {
      console.log('WebSocketPort not intialised, can\'t pass to client.');
    }
  });

  // Open the socket.
  udpPort.open();

  // When the port is read, send an OSC message to, say, SuperCollider
  udpPort.on("ready", function() {
    console.log(`Receiving OSC on ${HOST}:${PORT}`);
  });

};

export default websocketApp;