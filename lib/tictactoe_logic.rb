class TicTacToeLogic
    def get_winner(grid_cells)
        if (grid_cells[0][0] == grid_cells[0][1]) \
                && (grid_cells[0][1] == grid_cells[0][2])
            grid_cells[0][0]
        end
    end
end