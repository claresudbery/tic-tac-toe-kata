require "sinatra/base"
require "erb"

class MyApp < Sinatra::Base
    enable :sessions

    get '/tictactoe' do
        update_template_vars_from_session
        erb :tictactoe
    end

    post "/tictactoe" do
        update_session_vars_from_inputs
        update_template_vars_from_session
        erb :tictactoe
    end

    run! if app_file == $0

    private

    def update_session_vars_from_inputs
        session[:row1_col1] = params["row1_col1_in"]
        session[:row1_col2] = params["row1_col2_in"]
        session[:row1_col3] = params["row1_col3_in"]
        session[:row2_col1] = params["row2_col1_in"]
        session[:row2_col2] = params["row2_col2_in"]
        session[:row2_col3] = params["row2_col3_in"]
        session[:row3_col1] = params["row3_col1_in"]
        session[:row3_col2] = params["row3_col2_in"]
        session[:row3_col3] = params["row3_col3_in"]
    end

    def update_template_vars_from_session
        @rowcol = Array.new(3){ Array.new(3) { "" } }
        @rowcol[0][0] = session[:row1_col1]
        @rowcol[0][1] = session[:row1_col2]
        @rowcol[0][2] = session[:row1_col3]
        @rowcol[1][0] = session[:row2_col1]
        @rowcol[1][1] = session[:row2_col2]
        @rowcol[1][2] = session[:row2_col3]
        @rowcol[2][0] = session[:row3_col1]
        @rowcol[2][1] = session[:row3_col2]
        @rowcol[2][2] = session[:row3_col3]
    end
end