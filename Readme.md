# Alysson Anthony's solution for Potloc's shoe-store exercise

## What is this

I meant to highlight my ideas, assumptions and process for solving the technical exercise. It is also meant as a conversation starter so we can discuss my approach to the exercise open-mindedly. I would also like to discuss why I am an excellent fit for Potloc and what value I can add to the Questionnaire team and Potloc's road to a bright future.

## Structure
This readme will show the iterations the solution has gone through until its final state.

The iterations will simulate a conversation between a developer and a customer, going through several iterations. Apart from the history of commits, you can check the state of the solution at the end of each iteration through git's tags.

My initial assumptions:
 - I cannot change any of the code provided in the exercise
 - I can use any technology, language, framework, package, gem, etc.
 - I will run the solution on my computer for now, so there is no need for dockerizing it.
 - It is more important to show how I like to work than to create an extensive solution.
 - It is more important to show my knowledge of different aspects of software development than to create a complex solution.
 - The development of the solution should take between 4 to 8 hours.
 - The solution will be made iteratively, with each iteration taking approximately one hour / two pomodoros (https://en.wikipedia.org/wiki/Pomodoro_Technique).
 - It is okay to use a storytelling structure whenever I see fit.

I hope you have as much fun reading this as I had when creating it. So, without further ado:

## Iterations

### Iteration 1 - Starting out
_I cannot stand anymore having to check the inventory of each of our stores! I need a single source of truth, a centralized view of our inventory. Get me on a call with Anthony right now. I bet he can have something done before the end of the day!_ - Mr. Aldo.

After a brief talk with him, we checked our annotations:

```
	- Aldo will be the sole user of the solution for the time being
	- The solution needs to be kept as simple as possible
	- Software quality (fewer bugs) is a must
	- An easily adaptable/extensible solution is a must
	- A simple but functional solution is preferred to a complex one
```


Our journey starts laying the groundwork for solving Mr. Aldo's problem. After some analysis and planning, we choose to make the initial solution in NodeJS. 

The first iteration was to set up our repository and a websockets client based on NodeJS to receive the inventory updates and show them in the console. We also made the initial documentation.


The original exercise code is inside the _shoe-store-master_ directory. To run the server:
```
cd shoe-store-master
websocketd --port=8080 ruby inventory.rb
```

The websockets client code is inside the _inventory-listener_ directory. To run the client:
```
cd inventory_listener
npm start
```

At the end of the iteration, we could show the inventory updates of all stores in a single console window.


### Iteration 2 - Persistence and Queue
_Well, that is something. What happens if I open the solution at 8 pm? My stores will be closed, with no new updates sent. How will I know the state of the inventory, then?_ - Mr. Aldo.

As Aldo's subsequent demand involved persistence, we decided to create a new Rails application. Rails is also a good fit for the demands he said may come next.

	- We created a new Rails 7.0.6 application without a test suite (-T flag) and added RSpec afterward. It can be found in the inventory-hub directory. 
	- For the database, we decided to have three tables: stores, models and inventory.
	- We modified the inventory-listener to post the updates to the Rails application instead of writing to the console
	- The Rails app receives requests from the inventory-listener and updates the database
	- When the Rails app starts, it shows the current inventory on the console
	- The Rails app also shows inventory updates in the console as they are processed


At the current state, to get our entire solution up:
```
websocketd --port=8080 ruby inventory.rb    # in \shoe-store-master
npm start                                   # in \inventory-listener
rails start                                 # in \inventory-hub
```

To check our tests:
```
npm test                                   # in \inventory-listener
rspec                                      # in \inventory-hub
```


Ultimately, we could transfer the messages received from inventory-listener to inventory-hub. There, we were able to persist the inventory state on the database (defaults to SQLite) and show the last known inventory state on application startup.