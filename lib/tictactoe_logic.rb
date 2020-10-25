class TicTacToeLogic
    def get_winner(grid_cells)
        winner = nil
        i = 0

        while winner == nil && i < 3
            if !grid_cells[i][0].nil? && !grid_cells[i][0].empty? \
                    && (grid_cells[i][0] == grid_cells[i][1]) \
                    && (grid_cells[i][1] == grid_cells[i][2])
                winner = grid_cells[i][0]
            end  
            i = i + 1
        end

        winner
    end
end