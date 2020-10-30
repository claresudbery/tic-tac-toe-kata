require_relative './full_grid_error'

class Grid
    attr_accessor :cells

    def initialize(cells = nil)
        @cells = cells.nil? ? Array.new(3){ Array.new(3) { "" } } : cells
    end

    def clear
    end

    def empty_spaces
        empty_cells = empty_spaces_no_exception
        
        if empty_cells.empty?
            raise FullGridError.new
        else
            empty_cells            
        end
    end

    def empty_spaces_no_exception
        empty_cells = []

        @cells.each_with_index do |row, row_index|
            row.each_with_index do |symbol, column_index|
                if Utils::nil_or_empty?(symbol)
                    empty_cells << [column_index, row_index]
                end
            end
        end

        empty_cells
    end

    def copy
        copy_cells = Marshal.load(Marshal.dump(@cells))
        Grid.new(copy_cells)
    end

    def is_full
        it_is_full = true
        !@cells.each do |row|
            it_is_full = it_is_full && !row.include?("")
        end
        it_is_full
    end

    def play_move(coord, player)
        if @cells[coord[1]][coord[0]].nil? || @cells[coord[1]][coord[0]].empty?
            @cells[coord[1]][coord[0]] = player
        end
    end
end