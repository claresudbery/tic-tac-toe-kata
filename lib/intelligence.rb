require_relative './utils'
require_relative './full_grid_error'

class Intelligence
    def choose_move(grid, next_player)
        empty_spaces = Grid::empty_spaces(grid)
        if empty_spaces.empty?
            raise FullGridError.new
        else
            Grid::empty_spaces(grid)[0]            
        end
    end
end