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
        
        it "can detect when a player has won with a vertical row" do
            # Arrange
            winning_grid = [["X", "", ""],
                            ["X", "", ""],
                            ["X", "", ""]]

            # Act
            result = TicTacToeLogic.new.get_winner(winning_grid)

            # Assert
            expect(result).to eq("X")
        end
    end
end