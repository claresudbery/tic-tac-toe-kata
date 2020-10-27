require "spec_helper"
require_relative '../lib/grid'
require_relative '../lib/utils'

RSpec.describe 'The Grid class' do
    context "finding empty spaces" do 
        it "will return coords for the whole grid when all spaces are empty" do
            # Arrange                
            grid = [["", "", ""],
                    ["", "", ""],
                    ["", "", ""]] 
            expected_result =  [[0,0], [1,0], [2,0],
                                [0,1], [1,1], [2,1],
                                [0,2], [1,2], [2,2]]

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
            expected_result =  [[0,0], [3,0],
                                [2,1], [3,1],
                                [1,2], [2,2], [3,2]]

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

    context "checking if grid is full" do 
        it "will say grid is full when it is" do
            # Arrange                
            grid = [["X", "X", "X"],
                    ["X", "Z", "X"],
                    ["X", "X", "X"]] 

            # Act
            result = Grid::is_full(grid)

            # Assert
            expect(result).to eq(true)
        end

        # Arrange                
        non_full_grids = [
            [["", "", ""],
             ["", "", ""],
             ["", "", ""]],
            
            [["X", "",  ""],
             ["",  "Z", ""],
             ["",  "O", ""]],
            
            [["X", "O", "X"],
             ["X", "X", "O"],
             ["O", "O", ""]],
        ]

        non_full_grids.each do |grid_cells|
            it "will not say grid is full if it isn't" do
                # Act
                result = Grid::is_full(grid_cells)
    
                # Assert
                expect(result).to eq(false)
            end
        end        
    end
end