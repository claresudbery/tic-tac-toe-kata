class TicTacToeLogic
    def get_winner(grid_cells)
        if !grid_cells[0][0].nil? && !grid_cells[0][0].empty? \
                && (grid_cells[0][0] == grid_cells[0][1]) \
                && (grid_cells[0][1] == grid_cells[0][2])
            grid_cells[0][0]
        elsif !grid_cells[1][0].nil? && !grid_cells[1][0].empty? \
                && (grid_cells[1][0] == grid_cells[1][1]) \
                && (grid_cells[1][1] == grid_cells[1][2])
            grid_cells[1][0]
        end  

        # puts "*******************************************************"
        # puts "grid_cells[0][0]: " + grid_cells[0][0]
        # puts "grid_cells[0][1]: " + grid_cells[0][1]
        # puts "grid_cells[0][2]: " + grid_cells[0][2]
        # puts "grid_cells[1][0]: " + grid_cells[1][0]
        # puts "grid_cells[1][1]: " + grid_cells[1][1]
        # puts "grid_cells[1][2]: " + grid_cells[1][2]
        # puts "grid_cells[2][0]: " + grid_cells[2][0]
        # puts "grid_cells[2][1]: " + grid_cells[2][1]
        # puts "grid_cells[2][2]: " + grid_cells[2][2]
        # puts "*******************************************************"
    end
end