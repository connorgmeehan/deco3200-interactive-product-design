import osc from 'osc';
import WebSocket from 'ws';


const websocketApp = (server) => {
  const HOST = process.env.DISPLAY_HOST || "localhost";
  const PORT = process.env.DISPLAY_PORT || "8080";
  
  // Listen for Web Socket requests.
  var wss = new WebSocket.Server({
    server: server
  });

  let socketPorts = [];
  // Listen for Web Socket connections.
  wss.on("connection", function(socket) {

    socketPorts.push(
      new osc.WebSocketPort({
        socket: socket,
        metadata: true
      })
    );
  });

  // Recieving OSC 
  var udpPort = new osc.UDPPort({
    localAddress: HOST,
    localPort: Number.parseInt(PORT) + 1,
    metadata: true
  });

  // Listen for incoming OSC messages.
  udpPort.on("message", function(oscMsg, timeTag, info) {
    console.log("An OSC message just arrived!", oscMsg.address, info.size);
    console.log("Remote info is: ", info);
    if (socketPorts) {
      let failedSocketIndices = [];

      // Iterate through active sockets
      socketPorts.forEach((socket, i) => {
        try {
          socket.send({
            address: oscMsg.address,
            args: oscMsg.args,
          });
        } catch {
          failedSocketIndices.push(i);
        }
      });

      // Remove failed sockets
      failedSocketIndices.forEach(socketToRemoveIndex => {
        socketPorts.splice(socketToRemoveIndex, 1);
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