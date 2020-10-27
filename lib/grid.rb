class Grid
    def self.empty_spaces(grid)
        empty_spaces = []

        grid.each_with_index do |row, row_index|
            row.each_with_index do |symbol, column_index|
                if Utils::nil_or_empty?(symbol)
                    empty_spaces << [row_index, column_index]
                end
            end
        end
        
        return empty_spaces
    end
end