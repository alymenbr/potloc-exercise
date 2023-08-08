
const WebSocket = require('ws');
const fetch = require('node-fetch')

const INVENTORY_HUB_ENDPOINT = process.env.INVENTORY_HUB_ENDPOINT
const ws = new WebSocket('ws://localhost:8080/');

ws.on('error', console.error);

ws.on('open', function open() {
  ws.send('opened');
});

ws.on('message', async function message(data) {
  await handle_message(data);
});

async function handle_message(message) {

  try{
    const response = await fetch(INVENTORY_HUB_ENDPOINT, {
      method: 'post',
      body: message,
      headers: {'Content-Type': 'application/json'}
    });
  
    if(response.status === 201)
      console.log(`sent: ${message}`)
    else
      console.log(`error: ${message}`)
  }
  catch(error) {
    console.log(`exception: ${error}`)
  }
}

exports.handle_message = handle_message;