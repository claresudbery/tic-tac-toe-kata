# tic-tac-toe-kata

Using Ruby to tackle the tic-tac-toe kata.

The kata is based on [this exercise](https://learn.madetech.com/sparring/tic-tac-toe/).

The Sinatra part of this app was mostly based on learnings from [this tutorial](http://webapps-for-beginners.rubymonstas.org/sinatra/params.html).

The AI part of this app uses the [minimax algorithm](https://towardsdatascience.com/tic-tac-toe-creating-unbeatable-ai-with-minimax-algorithm-8af9e52c1e7d), which can be awkward to TDD. I got through it by drawing a lot of diagrams, which are all visible - plus brief notes - [here](./notes.md)

More useful Ruby links [here](https://clare-wiki.herokuapp.com/pages/coding/lang/oo/Ruby).

## Getting Started

Remember to run `bundle install` if there is a `Gemfile` in the project.

To start the app / spin up the server, run the following on the command line: `rackup -p 4567`. Then go to http://localhost:4567/tictactoe in your browser.

Alternatively you can still just use: `ruby tictactoe.rb`
and visit http://localhost:4567/tictactoe. Ah, no! That's not true! That's since I've introduced the MyApp class - you can't just run it like that any more. You'll get an error something like "undefined local variable or method update_template_vars_from_session".

## Deploying to Heroku via Travis

The following files were added to make this work:
- Procfile (probably not actually needed)
- LICENSE.TXT (because open source projects can be deployed for free using Travis)
- favicon.ico (probably not actually needed)
- .travis.yml (definitely needed)

!! Note that I was getting errors for ages in the logs (`heroku logs --tail --app tic-tac-toe-kata`) saying "No web processes running". The solution was to go to [the resources section in heroku](https://dashboard.heroku.com/apps/tic-tac-toe-kata/resources), then under Free Dynos, click the Edit button (pencil icon) over on the right, and turn the switch on to activate the web dyno.

## Docker

Note that there is now a docker file, and a Dockerised version of this app has been [deployed to Heroku here](https://tic-tac-toe-docker.herokuapp.com/tictactoe). Use the following command to run the docker container locally:

`docker run -p 80:5000 -e PORT=5000 hello`

(This is assuming you added the `hello` tag when you built your image using `docker build`, like this: ` docker build --tag hello .`).