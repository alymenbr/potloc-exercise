const main = require('./main')

// Disable the ws constructor during tests
const ws = require("ws");
jest.mock('ws');
ws.mockImplementation( (params) => {})

// Mock the fetch package
const fetch = require("node-fetch");
jest.mock('node-fetch');


const set_fetch_success = () => {
  fetch.mockReset()
  fetch.mockReturnValue({ status: 201}) // 201: created
}

const set_fetch_failed = () => {
  fetch.mockReset()
  fetch.mockReturnValue({ status: 422}) // 422: unprocessable entity
}

const set_fetch_exception = (message) => {
  fetch.mockReset()
  fetch.mockImplementation((url, options) => { throw message})
}


describe("The behaviour of the output messages from the listener", () => {
  
  const original_log = console.log; // save original console.log function
  beforeEach(() => {
    console.log = jest.fn(); // create a new mock function for each test
  });
  afterAll(() => {
    console.log = original_log; // restore original console.log after all tests
  });

  test('the received string message must be output to the console, preceded by "update: " ', async () => {
    set_fetch_success()

    const message = 'a very small message'
    await main.handle_message(message)

    expect(console.log).toHaveBeenCalledWith(`sent: ${message}`);
  });

  test('the received json must be output to the console, preceded by "update: " ', async () => {
    set_fetch_success()

    const json = {field1: 'value1', field2: 'value2'}
    await main.handle_message(json)

    expect(console.log).toHaveBeenCalledWith(`sent: ${json}`);
  });


  test('report response errors on the console" ', async () => {
    set_fetch_failed()
    
    const json = {field1: 'value1', field2: 'value2'}
    await main.handle_message(json)

    expect(console.log).toHaveBeenCalledWith(`error: ${json}`);
  });

  test('report fetch exceptions on the console" ', async () => {
    const exception_message = "A exception message"
    set_fetch_exception(exception_message)
    
    await main.handle_message('a message')

    expect(console.log).toHaveBeenCalledWith(`exception: ${exception_message}`);
  });   
});  