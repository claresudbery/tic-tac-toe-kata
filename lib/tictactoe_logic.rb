class TicTacToeLogic
    def get_winner(rows)
        winner = nil
        i = 0
        columns = rows.transpose
        diagonals = [[rows[0][0], rows[1][1], rows[2][2]],
                     [rows[0][2], rows[1][1], rows[2][0]]]
        all_lines = rows + columns + diagonals

        while winner == nil && i < all_lines.length 
            winner = find_winner_in_line(all_lines[i])
            i = i + 1
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