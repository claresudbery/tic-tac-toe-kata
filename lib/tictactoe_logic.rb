class TicTacToeLogic
    def get_winner(grid_cells)
        winner = nil
        i = 0
        transposed_grid = grid_cells.transpose

        while winner == nil && i < 3 
            winner = find_horizontal_winner(grid_cells[i])
            winner = winner.nil? ? find_horizontal_winner(transposed_grid[i]) : winner
            i = i + 1
        end

        winner
    end

    private 

    def find_horizontal_winner(grid_row)
        if !grid_row[0].nil? && !grid_row[0].empty? \
                && (grid_row[0] == grid_row[1]) \
                && (grid_row[1] == grid_row[2])
            winner = grid_row[0]
        end 
    end
end