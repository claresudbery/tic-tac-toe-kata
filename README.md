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
    - To get this working, you need a Heroku API key. To get that, follow these instructions:
    - Install the [Heroku](https://devcenter.heroku.com/articles/heroku-cli) and [Travis](https://github.com/travis-ci/travis.rb#installation) command line clients.
    - Follow [the instructions over at Travis CI's website](https://docs.travis-ci.com/user/getting-started/#to-get-started-with-travis-ci).
    - If you are using RSpec, all you need to know is your Ruby version for the `rvm` section (use `ruby -v` on the command line), and then your `.travis.yml` file can be as simple as:

```
language: ruby
script: bundle exec rspec
rvm:
  - 2.5.0  
```

- Note that the above travis.yml assumes you have a `Gemfile` - which can be as simple as [this one](https://github.com/claresudbery/mars-rover-kata-ruby/blob/fdff2aefca3456dddab635f494fd885b63aa965e/Gemfile). You'll also need a `Gemfile.lock` later on to get Heroku working - you can create one by running `bundle install` after you've added your `Gemfile`.
- If your GitHub project is at `github.com/mygithub/tictactoe`, your Travis CI build will be at `travis-ci.org/mygithub/tictactoe`.
- You might notice that the `.travis.yml` file in this repo has an `api_key` section. That's the last piece you need to get things deployed to Heroku. Navigate to your repo folder and run the following commands (if on Windows, you might need to use Windows Terminal):

```
travis login --pro
travis encrypt $(heroku auth:token) --add deploy.api_key --com
```

    - This will add your encrypted Heroku API key to `.travis.yml`, which you will then have to push to the remote (`git push`). It's important to note that this API key is encrypted. You should never push unencrypted API keys / secrets to source control, particularly not for open source projects. Instead, do something like use a .env file and configure the secret in Travis rather than exposing it in source code.

!! Note that I was getting errors for ages in the logs (`heroku logs --tail --app tic-tac-toe-kata`) saying "No web processes running". The solution was to go to [the resources section in heroku](https://dashboard.heroku.com/apps/tic-tac-toe-kata/resources), then under Free Dynos, click the Edit button (pencil icon) over on the right, and turn the switch on to activate the web dyno.

## Docker

Note that there is now a docker file, and a Dockerised version of this app has been [deployed to Heroku here](https://tic-tac-toe-docker.herokuapp.com/tictactoe). Use the following command to run the docker container locally:

`docker run -p 80:5000 -e PORT=5000 hello`

(This is assuming you added the `hello` tag when you built your image using `docker build`, like this: ` docker build --tag hello .`).