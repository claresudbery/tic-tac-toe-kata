require "sinatra/base"
require "erb"
require_relative './lib/tictactoe_logic'

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

    post "/reset" do
        clear_session_vars
        clear_template_vars
        erb :tictactoe
    end

    run! if app_file == $0

    private

    def update_winner
        @winner = TicTacToeLogic.new.get_winner(@cells)
    end

    def update_session_vars_from_inputs
        if session[:cell_values] == nil
            session[:cell_values] = Array.new(3){ Array.new(3) { "" } }
        end

        for row in 0..2 
            for col in 0..2 
                session[:cell_values][row][col] = params["row#{row}_col#{col}_in"]
            end
        end
    end

    def update_template_vars_from_session
        @cells = Array.new(3){ Array.new(3) { "" } }

        if session[:cell_values] == nil
            session[:cell_values] = Array.new(3){ Array.new(3) { "" } }
        end
        
        unless session[:cell_values] == nil 
            for row in 0..2 
                for col in 0..2 
                    @cells[row][col] = session[:cell_values][row][col]
                end
            end
        end

        update_winner
    end

    def clear_session_vars
        if session[:cell_values] == nil
            session[:cell_values] = Array.new(3){ Array.new(3) { "" } }
        end

        for row in 0..2 
            for col in 0..2 
                session[:cell_values][row][col] = ""
            end
        end
    end

    def clear_template_vars
        @cells = Array.new(3){ Array.new(3) { "" } }

        unless session[:cell_values] == nil 
            for row in 0..2 
                for col in 0..2 
                    @cells[row][col] = ""
                end
            end
        end
    end
end