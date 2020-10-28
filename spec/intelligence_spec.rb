require "spec_helper"
require_relative '../lib/intelligence'
require_relative '../lib/grid'
require_relative '../lib/utils'
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
                      ["",  "",  ""],
                      ["X",  "",  ""]],
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
            [0,1] => [["O", "",  "X"],
                      ["",  "X", ""],
                      ["O", "",  ""]],
            [0,2] => [["",  "X", ""],
                      ["X", "",  ""],
                      ["",  "O", "O"]]
        }

        grids_where_other_player_could_win.each do |space_coords, grid_cells|
            it "will prevent #{MyApp::DEFAULT_OPPONENT_SYMBOL} from winning in this grid: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end

        # Arrange                
        grids_with_a_choice_between_win_or_draw = {
            [1,1] => [["X", "O", "X"], # see diagram F
                      ["",  "",  "O"],
                      ["",  "",  ""]],
            [1,1] => [["O", "", ""], # see diagram H
                      ["",  "", ""],
                      ["",  "", ""]]
        }

        grids_with_a_choice_between_win_or_draw.each do |space_coords, grid_cells|
            it "will choose the first winning move (instead of draw) in this grid: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end        

        # Arrange                
        grids_with_a_choice_between_draw_or_lose = {
            [2,2] => [["O", "X", "O"], # see diagram D
                      ["X", "O", ""],
                      ["X", "O", ""]]
        }

        grids_with_a_choice_between_win_or_draw.each do |space_coords, grid_cells|
            it "will choose the first move that leads to a draw (instead of losing) in this grid: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end      

        # Arrange                
        loss_is_unavoidable = {
            [1,0] => [["O", "",  "X"], # see diagram C
                      ["X", "O", ""],
                      ["X", "O", ""]]
        }

        loss_is_unavoidable.each do |space_coords, grid_cells|
            it "will choose the first losing space if loss is unavoidable: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end

        it "given an empty grid, all moves will be scored as a draw." do
            # Arrange                
            empty_grid = [["", "", ""],
                          ["", "", ""],
                          ["", "", ""]]  

            # Act
            result = Intelligence.new.get_minimax_score(empty_grid, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

            # Assert
            expect(result).to eq(0)
        end    

        # Arrange                
        quick_wins_and_slow_wins = {
            [1,1] => [["X", "",  ""], # see diagram E
                      ["",  "",  ""],
                      ["O", "O", "X"]],
            [0,2] => [["",  "O", "X"], # see diagram J
                      ["O", "X", ""],
                      ["",  "",  ""]],
            [2,1] => [["O", "O", "X"], # see diagram I
                      ["",  "",  ""],
                      ["",  "",  "X"]]
        }

        quick_wins_and_slow_wins.each do |space_coords, grid_cells|
            it "will favour a quick win over a slow win: #{grid_cells}" do
                # Act
                result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

                # Assert
                expect(result).to eq(space_coords)
            end
        end

        it "given a choice between multiple instant winning moves, it will choose the first." do
            # Arrange                
            grid_cells = [["X", "",  "X"], # see diagram E
                          ["O", "",  ""],
                          ["O", "O", "X"]]  

            # Act
            result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

            # Assert
            expect(result).to eq([1,0])
        end 

        it "given a choice between multiple non-instant winning moves, it will choose the first." do
            # Arrange                
            grid_cells = [["",  "O", ""], # see diagram G
                          ["O", "X", ""],
                          ["",  "X", ""]]  

            # Act
            result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

            # Assert
            expect(result).to eq([0,2])
        end 

        it "even if opponent will win eventually, still block a win in the next move." do
            # Arrange                
            grid_cells = [["O", "X", ""], # see diagram K
                          ["",  "",  "X"],
                          ["O", "",  ""]]  

            # Act
            result = Intelligence.new.choose_move(grid_cells, MyApp::DEFAULT_AI_SYMBOL, MyApp::DEFAULT_OPPONENT_SYMBOL)

            # Assert
            expect(result).to eq([0,1])
        end 
    end
end