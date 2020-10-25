require "spec_helper"

RSpec.describe 'The tic-tac-toe App' do
    context "deciding if somebody has won" do 
        horizontal_winning_rows = [
            ["X",  [["X", "X", "X"],
                    ["",  "",  ""],
                    ["",  "",  ""]]],
            ["X",  [["",  "",  ""],
                    ["X", "X", "X"],
                    ["",  "",  ""]]],
            ["X",  [["",  "",  ""],
                    ["",  "",  ""],
                    ["X", "X", "X"]]]
        ]

        # Arrange                
        horizontal_winning_rows.each do |player, grid_cells|
            it "can detect when #{player} has won with a horizontal row, like this: #{grid_cells}" do
                # Act
                result = TicTacToeLogic.new.get_winner(grid_cells)

                # Assert
                expect(result).to eq(player)
            end
        end

        vertical_winning_rows = [
            ["O",  [["O", "", ""],
                    ["O", "", ""],
                    ["O", "", ""]]],
            ["O",  [["", "O", ""],
                    ["", "O", ""],
                    ["", "O", ""]]],
            ["O",  [["", "", "O"],
                    ["", "", "O"],
                    ["", "", "O"]]]
        ]

        # Arrange                
        vertical_winning_rows.each do |player, grid_cells|
            it "can detect when #{player} has won with a vertical row, like this: #{grid_cells}" do
                # Act
                result = TicTacToeLogic.new.get_winner(grid_cells)

                # Assert
                expect(result).to eq(player)
            end
        end

        diagonal_winning_rows = [
            ["O",  [["O", "",  ""],
                    ["",  "O", ""],
                    ["",  "",  "O"]]],
            ["X",  [["",  "",  "X"],
                    ["",  "X", ""],
                    ["X", "",  ""]]]
        ]

        # Arrange                
        diagonal_winning_rows.each do |player, grid_cells|
            it "can detect when #{player} has won with a diagonal row, like this: #{grid_cells}" do
                # Act
                result = TicTacToeLogic.new.get_winner(grid_cells)

                # Assert
                expect(result).to eq(player)
            end
        end

        no_winner_grids = [
            [["O", "O", "X"],
             ["O", "O", "X"],
             ["X", "X", ""]],

            [["O", "O", "X"],
             ["X", "X", "O"],
             ["",  "",  ""]],

            [["O", "", "X"],
             ["X", "", "O"],
             ["O", "", "O"]],

            [["",  "X", "X"],
             ["X", "",  "O"],
             ["O", "X", ""]],

            [["", "", ""],
             ["", "", ""],
             ["", "", ""]]
        ]

        # Arrange                
        no_winner_grids.each do |grid_cells|
            it "will not declare a winner for a non-winning grid, like this: #{grid_cells}" do
                # Act
                result = TicTacToeLogic.new.get_winner(grid_cells)

                # Assert
                expect(result).to eq(nil)
            end
        end
    end

    context "deciding where to play next" do 
        it "will choose to play in the only empty space left" do
            # Arrange
            grid_cells = [["O", "O", "X"],
                          ["O", "O", "X"],
                          ["X", "X", ""]]

            # Act
            result = TicTacToeLogic.new.choose_move(grid_cells, "O")

            # Assert
            expect(result).to eq([2,2])
        end
    end
end