const main = require('./main')

describe("The behaviour of the output messages from the listener", () => {
  
  const original_log = console.log; // save original console.log function
  beforeEach(() => {
    console.log = jest.fn(); // create a new mock function for each test
  });
  afterAll(() => {
    console.log = original_log; // restore original console.log after all tests
  });


  test('the received string message must be output to the console, preceded by "update: " ', () => {
    const message = 'a very small message'
    main.handle_message(message)

    expect(console.log).toHaveBeenCalledWith(`update: ${message}`);
  });

  test('the received json must be output to the console, preceded by "update: " ', () => {
    const json = {field1: 'value1', field2: 'value2'}
    main.handle_message(json)

    expect(console.log).toHaveBeenCalledWith(`update: ${json}`);
  });
});  