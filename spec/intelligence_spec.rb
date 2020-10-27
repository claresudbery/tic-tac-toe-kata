require "spec_helper"
require_relative '../lib/intelligence'

RSpec.describe 'The Intelligence class' do
    context "deciding where to play next" do 
        it "will choose to play in the only empty space left" do
            # Arrange
            grid_cells = [["O", "O", "X"],
                          ["O", "O", "X"],
                          ["X", "X", ""]]

            # Act
            result = Intelligence.new.choose_move(grid_cells, "O")

            # Assert
            expect(result).to eq([2,2])
        end
    end
end