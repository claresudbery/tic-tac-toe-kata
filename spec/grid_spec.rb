require "spec_helper"
require_relative '../lib/grid'

RSpec.describe 'The Grid class' do
    context "finding empty spaces" do 
        it "will return coords for the whole grid when all spaces are empty" do
            # Arrange                
            grid = [["", "", ""],
                    ["", "", ""],
                    ["", "", ""]] 
            expected_result =  [[0,0], [0,1], [0,2],
                                [1,0], [1,1], [1,2],
                                [2,0], [2,1], [2,2]]

            # Act
            result = Grid::empty_spaces(grid)

            # Assert
            expect(result).to eq(expected_result)
        end

        it "will return coords for only the empty spaces" do
            # Arrange                
            grid = [["", "X", "X", ""],
                    ["X", "X", "", ""],
                    ["X", "", "", ""]] 
            expected_result =  [[0,0], [0,3],
                                [1,2], [1,3],
                                [2,1], [2,2], [2,3]]

            # Act
            result = Grid::empty_spaces(grid)

            # Assert
            expect(result).to eq(expected_result)
        end

        it "will raise FullGridError if there are no empty spaces" do
            # Arrange                
            grid = [["X", "X", "X"],
                    ["X", "X", "X"],
                    ["X", "X", "X"]] 

            # Act & Assert
            expect{Grid::empty_spaces(grid)}.to raise_error(FullGridError)
        end
    end
end