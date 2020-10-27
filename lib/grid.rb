require_relative './full_grid_error'

class Grid
    def self.empty_spaces(grid)
        empty_cells = []

        grid.each_with_index do |row, row_index|
            row.each_with_index do |symbol, column_index|
                if Utils::nil_or_empty?(symbol)
                    empty_cells << [row_index, column_index]
                end
            end
        end
        
        if empty_cells.empty?
            raise FullGridError.new
        else
            empty_cells            
        end
    end
end