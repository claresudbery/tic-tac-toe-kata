class WinFinder
    def self.get_winner(rows)
        columns = rows.transpose
        diagonals = [[rows[0][0], rows[1][1], rows[2][2]],
                     [rows[0][2], rows[1][1], rows[2][0]]]
        all_lines = rows + columns + diagonals

        find_winner_in_all_lines(all_lines)
    end

    private 

    def self.find_winner_in_all_lines(lines)
        winner = nil
        i = 0

        while winner == nil && i < lines.length 
            winner = find_winner_in_line(lines[i])
            i = i + 1
        end
        
        winner
    end

    def self.find_winner_in_line(grid_line)
        if !grid_line[0].nil? && !grid_line[0].empty? \
                && (grid_line[0] == grid_line[1]) \
                && (grid_line[1] == grid_line[2])
            winner = grid_line[0]
        end 
    end
end