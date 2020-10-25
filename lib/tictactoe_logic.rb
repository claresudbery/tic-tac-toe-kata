class TicTacToeLogic
    def get_winner(grid_cells)
        winner = nil
        i = 0
        transposed_grid = grid_cells.transpose

        while winner == nil && i < 3 
            winner = find_winner_in_line(grid_cells[i])
            winner = winner.nil? ? find_winner_in_line(transposed_grid[i]) : winner
            i = i + 1
        end

        if winner.nil?
            winner = check_left_diagonal_for_winner(grid_cells)
        end

        winner
    end

    private 

    def find_winner_in_line(grid_row)
        if !grid_row[0].nil? && !grid_row[0].empty? \
                && (grid_row[0] == grid_row[1]) \
                && (grid_row[1] == grid_row[2])
            winner = grid_row[0]
        end 
    end

    def check_left_diagonal_for_winner(grid_cells)
        if !grid_cells[0][0].nil? && !grid_cells[0][0].empty? \
                && (grid_cells[0][0] == grid_cells[1][1]) \
                && (grid_cells[1][1] == grid_cells[2][2])
            winner = grid_cells[0][0]
        end 
    end
end