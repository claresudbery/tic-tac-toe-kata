require "spec_helper"
require_relative '../lib/intelligence'

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
                result = Intelligence.new.choose_move(grid_cells, "O")

                # Assert
                expect(result).to eq(space_coords)
            end
        end
    end
end