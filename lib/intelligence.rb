require_relative './utils'

class Intelligence
    def choose_move(grid, next_player, opponent = MyApp::DEFAULT_OPPONENT_SYMBOL)
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

    private 

    def find_winning_move(grid, empty_spaces, player)
        chosen_move = nil

        empty_spaces.each do |empty_space|
            test_grid = Grid::copy(grid)
            Grid::play_move(test_grid, empty_space, player)
            if WinFinder.new.get_winner(test_grid) == player
                chosen_move = empty_space
            end
        end

        chosen_move
    end
end