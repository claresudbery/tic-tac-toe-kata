require "spec_helper"
require_relative '../lib/intelligence'
require_relative '../tictactoe'

RSpec.describe 'The Intelligence class' do
    context "deciding where to play next" do 
        # Arrange                
        grids_with_only_one_space = {
            [0,0] => [["", "O", "X"],["O", "X", "O"],["O", "X", "O"]],
            [0,1] => [["X", "O", "X"],["", "X", "O"],["O", "X", "O"]],
            [2,0] => [["X", "O", ""],["O", "X", "O"],["O", "X", "O"]],
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

        it "will not alter the grid when asked to choose a move" do
            # Arrange                
            original_grid = [["Z", "Z", "Z"],
                             ["Z", "Z", "Z"],
                             ["Z", "Z", ""]]             
            control_grid = Marshal.load(Marshal.dump(original_grid))

            # Act
            result = Intelligence.new.choose_move(original_grid, MyApp::DEFAULT_AI_SYMBOL)

            # Assert
            expect(original_grid).to eq(control_grid)
        end

        # Arrange                
        grids_where_ai_can_win = {
            [2,2] => [["X", "O", "O"],
                      ["O", "X", ""],
                      ["O", "X", ""]],
            [0,1] => [["X", "O", "O"],
                      ["",  "", ""],
                      ["X", "", ""]],
            [1,1] => [["O", "", "X"],
                      ["X", "", "O"],
                      ["X", "O",""]]
        }

        grids_where_ai_can_win.each do |space_coords, grid_cells|
            it "will choose to play #{MyApp::DEFAULT_AI_SYMBOL} in the winning spot if there is one: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end

        # Arrange                
        grids_where_other_player_could_win = {
            [2,2] => [["O", "X", "O"],
                      ["X", "O", ""],
                      ["X", "O", ""]],
            [0,1] => [["O", "X", "X"],
                      ["",  "", ""],
                      ["O", "", ""]],
            [2,0] => [["O", "O", ""],
                      ["X", "X", ""],
                      ["",  "",  ""]]
        }

        grids_where_other_player_could_win.each do |space_coords, grid_cells|
            it "will prevent #{MyApp::BACKUP_AI_SYMBOL} from winning in this grid: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end
    end
end