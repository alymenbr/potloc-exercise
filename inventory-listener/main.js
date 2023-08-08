
const WebSocket = require('ws');
const ws = new WebSocket('ws://localhost:8080/');

ws.on('error', console.error);

ws.on('open', function open() {
  ws.send('opened');
});

ws.on('message', function message(data) {
  handle_message(data);
});

function handle_message(message) {
  console.log(`update: ${message}`);
}


exports.handle_message = handle_message;