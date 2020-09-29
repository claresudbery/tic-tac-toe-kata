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
        if session[:cell_values] == nil
            session[:cell_values] = Array.new(3){ Array.new(3) { "" } }
        end

        session[:cell_values][0][0] = params["row1_col1_in"]
        session[:cell_values][0][1] = params["row1_col2_in"]
        session[:cell_values][0][2] = params["row1_col3_in"]
        session[:cell_values][1][0] = params["row2_col1_in"]
        session[:cell_values][1][1] = params["row2_col2_in"]
        session[:cell_values][1][2] = params["row2_col3_in"]
        session[:cell_values][2][0] = params["row3_col1_in"]
        session[:cell_values][2][1] = params["row3_col2_in"]
        session[:cell_values][2][2] = params["row3_col3_in"]
    end

    def update_template_vars_from_session
        @cells = Array.new(3){ Array.new(3) { "" } }

        unless session[:cell_values] == nil 
            for row in 0..2 
                for col in 0..2 
                    @cells[row][col] = session[:cell_values][row][col]
                end
            end
        end
    end
end