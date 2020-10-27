require_relative './utils'

class Intelligence
    def choose_move(grid, next_player)
        empty_spaces = Grid::empty_spaces(grid)
        chosen_move = empty_spaces[0]

        empty_spaces.each do |empty_space|
            test_grid = Grid::copy(grid)
            test_grid[empty_space[0]][empty_space[1]] = next_player
            if WinFinder.new.get_winner(test_grid) == next_player
                chosen_move = empty_space
            end
        end

        chosen_move
    end
end