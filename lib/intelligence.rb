require_relative './utils'
require_relative './full_grid_error'

class Intelligence
    def choose_move(grid, next_player)
        empty_spaces = Grid::empty_spaces(grid)
        first_empty_space(empty_spaces)
    end

    private 

    def first_empty_space(empty_spaces)
        if empty_spaces.empty?
            raise FullGridError.new
        else
            Grid::empty_spaces(grid)[0]            
        end
    end
end