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

    def get_minimax_score(grid, current_player, opponent)
        winner = @win_finder.get_winner(grid)
        if !winner.nil?
            score = (winner == current_player) ? WE_WIN : THEY_WIN
        else
            if Grid.is_full(grid) 
                score = DRAW
            else   
                score = find_best_move_recursively(grid, current_player, opponent)[:score]
            end
        end
        score
    end

    private 

    def no_more_moves_to_play(empty_spaces) 
        empty_spaces.empty? 
    end

    def choose_move_using_unbeatable_ai(grid, next_player, opponent)
        find_best_move_recursively(grid, next_player, opponent)[:best_move]
    end

    def find_instant_winning_move(grid, empty_spaces, current_player)
        instant_winning_move = nil

        index = 0
        found_instant_win = false
        while !found_instant_win && index < empty_spaces.length do
            test_grid = Grid::copy(grid)
            Grid::play_move(test_grid, empty_spaces[index], current_player)
            found_instant_win = (@win_finder.get_winner(test_grid) == current_player)
            instant_winning_move = empty_spaces[index]
            index = index + 1
        end

        instant_winning_move
    end

    def find_best_move_recursively(grid, current_player, opponent)
        empty_spaces = Grid::empty_spaces_no_exception(grid)        

        instant_winning_move = find_instant_winning_move(grid, empty_spaces, current_player)
        if !instant_winning_move.nil?
            chosen_move = instant_winning_move
            score = WE_WIN
        else
            score = -2
            index = 0
            found_a_winning_move = false
            while !found_a_winning_move && index < empty_spaces.length do
                test_grid = Grid::copy(grid)
                Grid::play_move(test_grid, empty_spaces[index], current_player)
                temp_score = get_opponent_score_and_invert_it(test_grid, opponent, current_player)
                found_a_winning_move = temp_score == WE_WIN ? true : false
                if (temp_score > score)
                    score = temp_score
                    chosen_move = empty_spaces[index]
                end
                index = index + 1
            end
        end

        { :score => score, :best_move => chosen_move }
    end

    def get_opponent_score_and_invert_it(test_grid, opponent, current_player)
        -1 * get_minimax_score(test_grid, opponent, current_player)
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