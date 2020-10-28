require_relative './utils'

class Intelligence
    WE_WIN = 1
    DRAW = 0
    THEY_WIN = -1

    def initialize
        @win_finder = WinFinder.new
    end

    def choose_move(grid, next_player, opponent = MyApp::DEFAULT_OPPONENT_SYMBOL)
        choose_move_using_unbeatable_ai(grid, next_player, opponent)
    end

    def get_minimax_score(grid, player, opponent)
        score = -2
        winner = @win_finder.get_winner(grid)
        if !winner.nil?
            score = (winner == player) ? WE_WIN : THEY_WIN
        else
            empty_spaces = Grid::empty_spaces_no_exception(grid)    
            if no_more_moves_to_play(empty_spaces)  
                score = DRAW
            else   
                index = 0
                found_a_winning_move = false
                while !found_a_winning_move && index < empty_spaces.length do
                    test_grid = Grid::copy(grid)
                    Grid::play_move(test_grid, empty_spaces[index], player)
                    temp_score = -1 * get_minimax_score(test_grid, opponent, player)
                    found_a_winning_move = temp_score == WE_WIN ? true : false
                    index = index + 1
                    score = temp_score > score ? temp_score : score
                end
            end
        end
        score
    end

    private 

    def no_more_moves_to_play(empty_spaces) 
        empty_spaces.empty? 
    end

    def choose_move_using_unbeatable_ai(grid, next_player, opponent)
        empty_spaces = Grid::empty_spaces_no_exception(grid)

        chosen_move = nil
        score = -2

        empty_spaces.each do |empty_space|
            test_grid = Grid::copy(grid)
            Grid::play_move(test_grid, empty_space, next_player)
            temp_score = -1 * get_minimax_score(test_grid, opponent, next_player)
            if (temp_score > score)
                score = temp_score
                chosen_move = empty_space
            end
        end

        chosen_move
    end

    def choose_move_using_beatable_ai(grid, next_player, opponent)
        empty_spaces = Grid::empty_spaces(grid)

        chosen_move = find_winning_move(grid, empty_spaces, next_player)

        if (chosen_move.nil?)
            chosen_move = find_winning_move(grid, empty_spaces, opponent)
        end

        if (chosen_move.nil?)
            chosen_move = empty_spaces[0]
        end

        chosen_move
    end

    def find_winning_move(grid, empty_spaces, player)
        chosen_move = nil

        empty_spaces.each do |empty_space|
            test_grid = Grid::copy(grid)
            Grid::play_move(test_grid, empty_space, player)
            if @win_finder.get_winner(test_grid) == player
                chosen_move = empty_space
            end
        end

        chosen_move
    end
end