import osc from 'osc';
import WebSocket from 'ws';

const websocketApp = (server) => {
  // Listen for Web Socket requests.
  var wss = new WebSocket.Server({
    server: server
  });

  let socketPort;
  // Listen for Web Socket connections.
  wss.on("connection", function(socket) {
    socketPort = new osc.WebSocketPort({
      socket: socket,
      metadata: true
    });

    socketPort.on("message", function(oscMsg) {
      console.log("An OSC Message was received!", oscMsg);
    });
  });

  // Recieving OSC 
  const listenPort = process.env.FACE_POINTS_DISPLAY_SERVER_PORT || "3001";

  var udpPort = new osc.UDPPort({
    localAddress: "localhost",
    localPort: listenPort,
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
    udpPort.send({
      address: "/s_new",
      args: [
        {
          type: "s",
          value: "default"
        },
        {
          type: "i",
          value: 100
        }
      ]
    }, "127.0.0.1", 8000);
  });

};

export default websocketApp;