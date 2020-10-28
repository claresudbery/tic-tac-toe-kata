require "sinatra/base"
require "erb"
require_relative './lib/win_finder'
require_relative './lib/intelligence'
require_relative './lib/utils'
require_relative './lib/full_grid_error'
require_relative './lib/grid'

class MyApp < Sinatra::Base
    DEFAULT_AI_SYMBOL = "X"
    DEFAULT_OPPONENT_SYMBOL = "O"
    BACKUP_AI_SYMBOL = DEFAULT_OPPONENT_SYMBOL

    enable :sessions

    get '/tictactoe' do
        update_template_vars_from_session
        update_winner
        erb :tictactoe
    end

    post "/tictactoe" do
        update_session_vars_from_inputs
        update_template_vars_from_session
        update_winner
        if nobody_has_won and grid_is_not_full
            choose_ai_move
        end
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
        begin
            ai_move = Intelligence.new.choose_move(@cells, session[:ai_symbol], session[:human_symbol])
            Grid::play_move(@cells, ai_move, session[:ai_symbol])
        rescue FullGridError => e
            # Do nothing. This block just prevents us from attempting to play a move in a full grid.
        end
    end

    def update_winner
        @winner = WinFinder::get_winner(@cells)
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

        decide_ai_aymbol
    end

    def decide_ai_aymbol
        num_inputs = 0
        for row in 0..2 
            for col in 0..2 
                input = params["row#{row}_col#{col}_in"]
                num_inputs = Utils::nil_or_empty?(input) ? num_inputs : num_inputs + 1
                first_input = Utils::nil_or_empty?(first_input) ? input : first_input
            end
        end
        set_ai_symbol(num_inputs, first_input)
    end

    def set_ai_symbol(num_inputs, first_input)
        if num_inputs == 1
            session[:ai_symbol] = (first_input == DEFAULT_AI_SYMBOL ? BACKUP_AI_SYMBOL : DEFAULT_AI_SYMBOL)
            session[:human_symbol] = first_input
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

    def nobody_has_won
        @winner.nil?
    end
    
    def grid_is_not_full
        !Grid::is_full(@cells)
    end
end