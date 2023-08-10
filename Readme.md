# Alysson Anthony's solution for Potloc's shoe-store exercise

### What is this

I meant to highlight my ideas, assumptions and process for solving the technical exercise. It is also meant as a conversation starter so we can discuss my approach to the exercise open-mindedly. I would also like to discuss why I am an excellent fit for Potloc and what value I can add to the Questionnaire team and Potloc's road to a bright future.

# Structure
This readme will show the iterations the solution has gone through until its final state.

The iterations will simulate a conversation between a developer and a customer, going through several iterations. Apart from the history of commits, you can check the state of the solution at the end of each iteration through git's tags.

My initial assumptions:
 - I cannot change any of the code provided in the exercise
 - I can use any technology, language, framework, package, gem, etc.
 - I will run the solution on my computer for now, so there is no need for dockerizing it.
 - It is more important to show how I like to work than to create an extensive solution.
 - It is more important to show my knowledge of different aspects of software development than to create a complex solution.
 - The development of the solution should take between 4 to 8 hours.
 - The solution can be made iteratively. I will register a "snapshot" of the solution at the end of each iteration.
 - It is okay to use a storytelling structure whenever I see fit.

I hope you have as much fun reading this as I had when creating it. So, without further ado:

# Iterations

## Iteration 1 - Starting out 
_I cannot stand anymore having to check the inventory of each of our stores! I need a single source of truth, a centralized view of our inventory. Get me on a call with Anthony right now. I bet he can have something done before the end of the day!_ - Mr. Aldo.

After a brief talk with him, we checked our meeting notes:
 - Aldo will be the sole user of the solution for the time being
 - The solution needs to be kept as simple as possible
 - Software quality (fewer bugs) is a must
 - An easily adaptable/extensible solution is a must
 - A simple but functional solution is preferred to a complex one

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


### Results
At the end of the iteration, we could show the inventory updates of all stores in a single console window:

#### inventory-listener receiving inventory updates

https://github.com/alymenbr/potloc-exercise/assets/1554358/b1c83b7d-0542-4d65-be9b-0b2940ccd5bb

[Repository state at end of Iteration 1.](https://github.com/alymenbr/potloc-exercise/releases/tag/iteration_1)


## Iteration 2 - Persistence
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


### Results
Ultimately, we could transfer the messages received from inventory-listener to inventory-hub. There, we were able to persist the inventory state on the database (defaults to SQLite) and show the last known inventory state on application startup:

#### inventory-listener reposting inventory updates

https://github.com/alymenbr/potloc-exercise/assets/1554358/cd552ede-1699-489e-9e1c-9db223cab03c

#### inventory-hub receiving inventory updates

https://github.com/alymenbr/potloc-exercise/assets/1554358/a99953ab-f630-4f67-9b7b-fb4239febd60

#### inventory-hub showing persisted inventory on startup

https://github.com/alymenbr/potloc-exercise/assets/1554358/8db2af05-2255-4c2f-a0bf-9d3fc5baf8ba

[Repository state at end of Iteration 2.](https://github.com/alymenbr/potloc-exercise/releases/tag/iteration_2)


## Iteration 3 - A new UI
_When I asked for a system, I never thought I would be looking at a bland console window. Right now, this looks like an ancient bulletin board system! Can you make this into a webpage or something like that?_ - Mr. Aldo

Aldo seems to be surprised that we are still working on the console. It is now time to change that.

We choose Tailwind as a practical CSS framework to help us add some styling to the new UI.

After some thought, we decided to have three views for Mr. Aldo:
 - A General Inventory page showing the inventory of all models in all store
 - A Store Inventory page showing the inventory of all models in a specific store
 - A Model Inventory page showing the availability of a specific model in all stores

We also added some primary navigation between the views. As only Mr. Aldo will be using the solution for now, he wanted us to spend no effort adding user authentication/authorization.

At the current state, to get our entire solution up:
```
websocketd --port=8080 ruby inventory.rb    # in \shoe-store-master
npm start                                   # in \inventory-listener
rails start                                 # in \inventory-hub
```

To check our updated tests:
```
npm test                                   # in \inventory-listener
rspec                                      # in \inventory-hub
```

To access the webpage view of the inventory:
```
http://localhost:3000/inventories          # in any Browser
```


### Results
At the end of this iteration, we could show the global inventory, store specific inventory, and model specific availability using a simple but functional web interface.

#### inventory-hub web interface

https://github.com/alymenbr/potloc-exercise/assets/1554358/fe846782-b177-490b-be24-6eb346984be9

[Repository state at end of Iteration 3.](https://github.com/alymenbr/potloc-exercise/releases/tag/iteration_3)


## Iteration 4 - A reactive UI
_The webpage view is better, but I still need to keep refreshing the page to see any changes. My thumbs will get sore if I keep refreshing the page like that. Can you make the changes appear automatically?_ - Mr. Aldo.

For Mr. Aldo's latest need, we can leverage Rails Hotwire frameworks to make the pages more reactive.

Rails Turbo Frames were used to update user views every time a new inventory update was received. Maintaining inventory ordering was a little tricky because, by default, new items would be appended at the end of the inventory list. The solution involved using client-side css properties.

We also added animated highlights on created or updated inventory items to help Aldo better visualize changes.

At the current state, to get our entire solution up:
```
websocketd --port=8080 ruby inventory.rb    # in \shoe-store-master
npm start                                   # in \inventory-listener
rails start                                 # in \inventory-hub
```

To check our updated tests:
```
npm test                                   # in \inventory-listener
rspec                                      # in \inventory-hub
```

To access the webpage view of the inventory:
```
http://localhost:3000/inventories          # in any Browser
```


### Results
At the end of this iteration, we could show the updated inventory quantities without manually refreshing the page.

#### inventory-hub reactive web interface

https://github.com/alymenbr/potloc-exercise/assets/1554358/881129ee-06e9-4367-b1a7-f26575ab75af

[Repository state at end of Iteration 4.](https://github.com/alymenbr/potloc-exercise/releases/tag/iteration_4)


## Iteration 5 - API availability and documentation
_I am a modern person. I want an API. I would love to access my inventory from some new service aggregation that gathers data from web api's. I may have someone get Alexa to tell me my inventory count. While you are at it, have some documentation ready, I don't want to have to remember any API shenanigans by memory in the future._ - Mr. Aldo.

At the request of Mr. Aldo, we added endpoints to check the global inventory, inventory for a specific shoe story, and availability for a particular shoe model. We also generated Swagger/OpenApi 2.0 compatible documentation and updated our tests. 

At the current state, to get our entire solution up:
```
websocketd --port=8080 ruby inventory.rb    # in \shoe-store-master
npm start                                   # in \inventory-listener
rails start                                 # in \inventory-hub
```

To check our updated tests:
```
npm test                                   # in \inventory-listener
rspec                                      # in \inventory-hub
```

To access the webpage view of the inventory:
```
http://localhost:3000/inventories          # in any Browser
```

To access the webpage view of the api documentation:
```
http://localhost:3000/api_docs/swagger/          # in any Browser
```


### Results
We finally have an API to extend the functionalities of Mr. Aldo's solution in the future: 

#### inventory-hub api and docs

https://github.com/alymenbr/potloc-exercise/assets/1554358/cc83576c-b49e-4b78-8cb3-034a3ff50315


[Repository state at end of Iteration 5.](https://github.com/alymenbr/potloc-exercise/releases/tag/iteration_5)


### One more thing
We have finished our exercise! 
...
Have we?
