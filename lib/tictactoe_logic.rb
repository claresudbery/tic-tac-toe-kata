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
            winner = find_winner_in_line([grid_cells[0][0], grid_cells[1][1], grid_cells[2][2]])
            winner = winner.nil? \
                ? find_winner_in_line([grid_cells[0][2], grid_cells[1][1], grid_cells[2][0]]) \
                : winner
        end

        winner
    end

    private 

    def find_winner_in_line(grid_line)
        if !grid_line[0].nil? && !grid_line[0].empty? \
                && (grid_line[0] == grid_line[1]) \
                && (grid_line[1] == grid_line[2])
            winner = grid_line[0]
        end 
    end
end