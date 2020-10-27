require "spec_helper"
require_relative '../lib/intelligence'
require_relative '../tictactoe'

RSpec.describe 'The Intelligence class' do
    context "deciding where to play next" do 
        # Arrange                
        grids_with_only_one_space = {
            [0,0] => [["", "O", "X"],["O", "X", "O"],["O", "X", "O"]],
            [1,0] => [["X", "O", "X"],["", "X", "O"],["O", "X", "O"]],
            [0,2] => [["X", "O", ""],["O", "X", "O"],["O", "X", "O"]],
            [2,2] => [["X", "O", "X"],["O", "X", "O"],["O", "X", ""]]
        }

        grids_with_only_one_space.each do |space_coords, grid_cells|
            it "will choose to play in the only empty space left: #{space_coords}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end

        it "will raise FullGridError if there are no empty spaces" do
            # Arrange                
            grid_cells = [["X", "X", "X"],
                          ["X", "X", "X"],
                          ["X", "X", "X"]] 

            # Act & Assert
            expect{Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL)}.to raise_error(FullGridError)
        end

        # Arrange                
        grids_where_ai_can_win = {
            [2,2] => [["X", "O", "O"],
                      ["O", "X", ""],
                      ["O", "X", ""]]
        }

        grids_where_ai_can_win.each do |space_coords, grid_cells|
            it "will choose to play #{MyApp::DEFAULT_AI_SYMBOL} in the winning spot if there is one: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end
    end
end