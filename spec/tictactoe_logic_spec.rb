require "spec_helper"

RSpec.describe 'The tic-tac-toe App' do
    context "deciding if somebody has won" do 
        winning_game_grids = [
            ["X",  [["X", "X", "X"],
                    ["",  "",  ""],
                    ["",  "",  ""]]],
            ["O",  [["O", "O", "O"],
                    ["",  "",  ""],
                    ["",  "",  ""]]],
            ["X",  [["",  "",  ""],
                    ["X", "X", "X"],
                    ["",  "",  ""]]],
            ["O",  [["",  "",  ""],
                    ["O", "O", "O"],
                    ["",  "",  ""]]],
            ["X",  [["",  "",  ""],
                    ["",  "",  ""],
                    ["X", "X", "X"]]],
            ["O",  [["",  "",  ""],
                    ["",  "",  ""],
                    ["O", "O", "O"]]]
        ]

        # Arrange                
        winning_game_grids.each do |player, grid_cells|
            it "can detect when #{player} has won with grid #{grid_cells}" do
                # Act
                result = TicTacToeLogic.new.get_winner(grid_cells)

                # Assert
                expect(result).to eq(player)
            end
        end
    end
end