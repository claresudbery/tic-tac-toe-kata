require "sinatra/base"
require "erb"

class MyApp < Sinatra::Base
    enable :sessions

    get '/tictactoe' do
        @row1_col1 = session[:row1_col1]
        @row2_col1 = session[:row2_col1]
        @row3_col1 = session[:row3_col1]
        @row1_col2 = session[:row1_col2]
        @row2_col2 = session[:row2_col2]
        @row3_col2 = session[:row3_col2]
        @row1_col3 = session[:row1_col3]
        @row2_col3 = session[:row2_col3]
        @row3_col3 = session[:row3_col3]
        erb :tictactoe
    end

    post "/tictactoe" do
        session[:row1_col1] = params["row1_col1_in"]
        session[:row2_col1] = params["row2_col1_in"]
        session[:row3_col1] = params["row3_col1_in"]
        session[:row1_col2] = params["row1_col2_in"]
        session[:row2_col2] = params["row2_col2_in"]
        session[:row3_col2] = params["row3_col2_in"]
        session[:row1_col3] = params["row1_col3_in"]
        session[:row2_col3] = params["row2_col3_in"]
        session[:row3_col3] = params["row3_col3_in"]
        @row1_col1 = session[:row1_col1]
        @row2_col1 = session[:row2_col1]
        @row3_col1 = session[:row3_col1]
        @row1_col2 = session[:row1_col2]
        @row2_col2 = session[:row2_col2]
        @row3_col2 = session[:row3_col2]
        @row1_col3 = session[:row1_col3]
        @row2_col3 = session[:row2_col3]
        @row3_col3 = session[:row3_col3]
        erb :tictactoe
    end

    run! if app_file == $0
end