require "spec_helper"
require_relative '../lib/win_finder'

RSpec.describe 'The Win Finder class' do
    context "deciding if somebody has won" do 
        # Arrange                
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

        horizontal_winning_rows.each do |player, grid_cells|
            it "can detect when #{player} has won with a horizontal row, like this: #{grid_cells}" do
                # Act
                result = WinFinder::get_winner(grid_cells)

                # Assert
                expect(result).to eq(player)
            end
        end

        # Arrange                
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

        vertical_winning_rows.each do |player, grid_cells|
            it "can detect when #{player} has won with a vertical row, like this: #{grid_cells}" do
                # Act
                result = WinFinder::get_winner(grid_cells)

                # Assert
                expect(result).to eq(player)
            end
        end

        # Arrange     
        diagonal_winning_rows = [
            ["O",  [["O", "",  ""],
                    ["",  "O", ""],
                    ["",  "",  "O"]]],
            ["X",  [["",  "",  "X"],
                    ["",  "X", ""],
                    ["X", "",  ""]]]
        ]
           
        diagonal_winning_rows.each do |player, grid_cells|
            it "can detect when #{player} has won with a diagonal row, like this: #{grid_cells}" do
                # Act
                result = WinFinder::get_winner(grid_cells)

                # Assert
                expect(result).to eq(player)
            end
        end

        # Arrange        
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
        
        no_winner_grids.each do |grid_cells|
            it "will not declare a winner for a non-winning grid, like this: #{grid_cells}" do
                # Act
                result = WinFinder::get_winner(grid_cells)

                # Assert
                expect(result).to eq(nil)
            end
        end
    end
end