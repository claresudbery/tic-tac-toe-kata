require "spec_helper"

RSpec.describe 'The tic-tac-toe App' do
    context "deciding if somebody has won" do  
      it "can detect when somebody has won" do
        # Arrange        
        grid_cells =  [["X", "", ""], \
                       ["X", "", ""], \
                       ["X", "", ""]]

        # Act
        result = TicTacToeLogic.new.get_winner(grid_cells)

        # Assert
        expect(result).to eq("X")
      end
    end
end