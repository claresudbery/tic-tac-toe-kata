require "sinatra/base"
require "erb"

class MyApp < Sinatra::Base

    @@session_vars = Array.new(3){ Array.new(3) { "" } }

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
        @@session_vars[0][0] = params["row1_col1_in"]
        @@session_vars[0][1] = params["row1_col2_in"]
        @@session_vars[0][2] = params["row1_col3_in"]
        @@session_vars[1][0] = params["row2_col1_in"]
        @@session_vars[1][1] = params["row2_col2_in"]
        @@session_vars[1][2] = params["row2_col3_in"]
        @@session_vars[2][0] = params["row3_col1_in"]
        @@session_vars[2][1] = params["row3_col2_in"]
        @@session_vars[2][2] = params["row3_col3_in"]

        session[:cell_values] = @@session_vars
    end

    def update_template_vars_from_session
        @cells = Array.new(3){ Array.new(3) { "" } }

        @cells[0][0] = session[:cell_values][0][0]
        @cells[0][1] = session[:cell_values][0][1]
        @cells[0][2] = session[:cell_values][0][2]
        @cells[1][0] = session[:cell_values][1][0]
        @cells[1][1] = session[:cell_values][1][1]
        @cells[1][2] = session[:cell_values][1][2]
        @cells[2][0] = session[:cell_values][2][0]
        @cells[2][1] = session[:cell_values][2][1]
        @cells[2][2] = session[:cell_values][2][2]
    end
end