require "sinatra/base"
require "erb"

# This page created as part of this tutorial: http://webapps-for-beginners.rubymonstas.org/sinatra/params.html

# To start the app / spin up the server, run the following on the command line: rackup -p 4567
# Alternatively you can still just use: ruby monstas.rb

class MyApp < Sinatra::Base
    enable :sessions

    get '/tictactoe' do
        erb :tictactoe
    end

    run! if app_file == $0
end