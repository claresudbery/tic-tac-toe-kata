require "sinatra/base"
require "erb"
require_relative './lib/tictactoe_logic'

class MyApp < Sinatra::Base
    enable :sessions

    get '/tictactoe' do
        update_template_vars_from_session
        update_winner
        erb :tictactoe
    end

    post "/tictactoe" do
        update_session_vars_from_inputs
        update_template_vars_from_session
        choose_ai_move
        update_winner
        erb :tictactoe
    end

    post "/reset" do
        clear_session_vars
        clear_template_vars
        erb :tictactoe
    end

    run! if app_file == $0

    private

    def choose_ai_move
        ai_move = TicTacToeLogic.new.choose_move(@cells, session[:ai_symbol])
        if @cells[ai_move[0]][ai_move[1]].nil? || @cells[ai_move[0]][ai_move[1]].empty?
            @cells[ai_move[0]][ai_move[1]] = session[:ai_symbol]
        end
    end

    def update_winner
        @winner = TicTacToeLogic.new.get_winner(@cells)
    end

    def update_session_vars_from_inputs
        if session[:cell_values] == nil
            session[:cell_values] = Array.new(3){ Array.new(3) { "" } }
        end

        num_inputs = 0
        for row in 0..2 
            for col in 0..2 
                session[:cell_values][row][col] = params["row#{row}_col#{col}_in"]
                num_inputs = (params["row#{row}_col#{col}_in"].nil? || params["row#{row}_col#{col}_in"].empty?) ? num_inputs : num_inputs + 1
                first_input = (first_input.nil? || first_input.empty?) ? params["row#{row}_col#{col}_in"] : first_input
            end
        end
        set_ai_symbol(num_inputs, first_input)
    end

    def set_ai_symbol(num_inputs, first_input)
        if num_inputs == 1
            session[:ai_symbol] = (first_input == "O" ? "X" : "O")
        else
            session[:ai_symbol] = params["ai_symbol"]
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