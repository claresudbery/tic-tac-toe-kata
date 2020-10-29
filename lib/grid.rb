require_relative './full_grid_error'

class Grid
    attr_accessor :cells

    def initialize(cells = nil)
        @cells = cells.nil? ? Array.new(3){ Array.new(3) { "" } } : cells
    end

    def clear
    end

    def self.empty_spaces(grid)
        empty_cells = empty_spaces_no_exception(grid)
        
        if empty_cells.empty?
            raise FullGridError.new
        else
            empty_cells            
        end
    end

    def self.empty_spaces_no_exception(grid)
        empty_cells = []

        grid.each_with_index do |row, row_index|
            row.each_with_index do |symbol, column_index|
                if Utils::nil_or_empty?(symbol)
                    empty_cells << [column_index, row_index]
                end
            end
        end

        empty_cells
    end

    def self.copy(grid)
        Marshal.load(Marshal.dump(grid))
    end

    def self.is_full(grid_cells)
        it_is_full = true
        !grid_cells.each do |row|
            it_is_full = it_is_full && !row.include?("")
        end
        it_is_full
    end

    def self.play_move(grid, coord, player)
        if grid[coord[1]][coord[0]].nil? || grid[coord[1]][coord[0]].empty?
            grid[coord[1]][coord[0]] = player
        end
    end
end