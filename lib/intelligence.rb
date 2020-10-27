require_relative './utils'

class Intelligence
    def choose_move(grid, next_player, opponent = MyApp::DEFAULT_OPPONENT_SYMBOL)
        empty_spaces = Grid::empty_spaces(grid)
        chosen_move = nil

        empty_spaces.each do |empty_space|
            test_grid = Grid::copy(grid)
            test_grid[empty_space[1]][empty_space[0]] = next_player
            if WinFinder.new.get_winner(test_grid) == next_player
                chosen_move = empty_space
            end
        end

        if (chosen_move.nil?)
            empty_spaces.each do |empty_space|
                test_grid = Grid::copy(grid)
                test_grid[empty_space[1]][empty_space[0]] = opponent
                if WinFinder.new.get_winner(test_grid) == opponent
                    chosen_move = empty_space
                end
            end
        end

        if (chosen_move.nil?)
            chosen_move = empty_spaces[0]
        end

        chosen_move
    end
end