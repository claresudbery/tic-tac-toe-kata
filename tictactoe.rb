require "sinatra/base"
require "erb"

class MyApp < Sinatra::Base
    enable :sessions

    get '/tictactoe' do
        erb :tictactoe
    end

    run! if app_file == $0
end