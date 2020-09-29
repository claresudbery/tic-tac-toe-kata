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

        for row in 0..2 
            for col in 0..2 
                session[:cell_values][row][col] = params["row#{row+1}_col#{col+1}_in"]
            end
        end
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