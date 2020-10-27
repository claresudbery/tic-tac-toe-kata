require_relative './utils'

class Intelligence
    def choose_move(grid, next_player)
        empty_spaces = Grid::empty_spaces(grid)
        empty_spaces[0]                 
    end

    private 

    def first_empty_space(empty_spaces)
        if empty_spaces.empty?
            raise FullGridError.new
        else
            empty_spaces[0]            
        end
    end
end