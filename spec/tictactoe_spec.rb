ENV['APP_ENV'] = 'test'

require "spec_helper"

require_relative '../tictactoe'
require 'rspec'
require 'rack/test'

RSpec.describe 'The tic-tac-toe App' do
    include Rack::Test::Methods
  
    def app
      MyApp
    end
  
    context "simple display" do  
      it "starts with an empty 3x3 tic-tac-toe grid" do
        # Act
        get '/tictactoe'

        # Assert
        expect(last_response).to be_ok
        for row in 0..2 
            for col in 0..2 
                expect(last_response.body).to have_tag('input', :with => { :class => "row#{row} col#{col}" })
            end
        end
      end
    end
  
    context "updated display after user input" do
      # Arrange
      grid_cells_with_css = {
        :row0_col0_in => {:css => 'input.row0.col0', :input => "A"},
        :row0_col1_in => {:css => 'input.row0.col1', :input => "B"},
        :row0_col2_in => {:css => 'input.row0.col2', :input => "C"},
        :row1_col0_in => {:css => 'input.row1.col0', :input => "D"},
        :row1_col1_in => {:css => 'input.row1.col1', :input => "E"},
        :row1_col2_in => {:css => 'input.row1.col2', :input => "F"},
        :row2_col0_in => {:css => 'input.row2.col0', :input => "G"},
        :row2_col1_in => {:css => 'input.row2.col1', :input => "H"},
        :row2_col2_in => {:css => 'input.row2.col2', :input => "I"}
      }

      grid_cells_with_css.each do |control, values|
        it "remembers when user makes a mark in a grid cell: '#{control}, #{values[:input]}'" do 
          # Act
          post "/tictactoe", control => values[:input] 

          # Assert
          expect(last_response).to be_ok
          expect(last_response.body).to have_tag(values[:css], :with => { :value => values[:input] })
        end
      end

      hash_of_inputs_for_all_cells = Hash[*grid_cells_with_css.map{ |k,v| [k, v[:input]] }.flatten]

      it "remembers data from previous posts even after multiple GET requests" do   
        # Arrange
        post "/tictactoe", hash_of_inputs_for_all_cells         
        get '/tictactoe'
        
        # Act
        get '/tictactoe'
        
        # Assert
        grid_cells_with_css.each do |control, values|
          expect(last_response.body).to have_tag(values[:css], :with => { :value => values[:input] })
        end
      end

      it "empties all cells on reset" do  
        # Arrange
        post "/tictactoe", hash_of_inputs_for_all_cells  
        grid_cells_with_css.each do |control, values|
          expect(last_response.body).to have_tag(values[:css], :with => { :value => values[:input] })
        end  

        # Act
        post "/reset"

        # Assert
        grid_cells_with_css.each do |control, values|
          expect(last_response.body).to have_tag(values[:css], :with => { :value => "" })
        end
      end
    end
  
    context "game logic" do
      it "tells user when somebody has won the game" do  
        # Arrange
        grid_cells =  [["X", "X", "X"],
                       ["",  "",  ""],
                       ["",  "",  ""]]

        # Act 
        post "/tictactoe", build_post_data(grid_cells)  

        # Assert
        expect(last_response.body).to include("X has won".upcase)
      end
      
      it "doesn't say somebody has won the game if they haven't" do  
        # Arrange
        grid_cells =  [["X", "O", ""],
                       ["X", "O", ""],
                       ["",  "",  ""]]

        # Act 
        post "/tictactoe", build_post_data(grid_cells)  

        # Assert
        expect(last_response.body).to_not include("X has won".upcase)
      end
    end
  
    context "artifical intelliigence" do
      grids_with_ai_symbol = [
          [MyApp::DEFAULT_AI_SYMBOL,  [["", "",  ""],
                  ["", MyApp::BACKUP_AI_SYMBOL, ""],
                  ["", "",  ""]]],
          [MyApp::BACKUP_AI_SYMBOL,  [["", "",  ""],
                  ["", MyApp::DEFAULT_AI_SYMBOL, ""],
                  ["", "",  ""]]],
          [MyApp::DEFAULT_AI_SYMBOL,  [["", "",  ""],
                  ["", "Z", ""],
                  ["", "",  ""]]]
      ]

      # Arrange                
      grids_with_ai_symbol.each do |ai_symbol, grid_cells|
        it "will choose a move, using the symbol #{ai_symbol}, after the user has played their first move like this: #{grid_cells}." do
          # Act 
          post "/tictactoe", build_post_data(grid_cells)  
  
          # Assert
          expect(last_response.body).to have_tag('input.row2.col2', :with => { :value => ai_symbol })
        end
      end

      it "will play the winning move if there is one" do  
        # Arrange
        grid_cells = [["X", "X", "O"],
                      ["X", "X", "O"],
                      ["O", "O", ""]]

        # Act 
        post "/tictactoe", build_post_data(grid_cells, MyApp::DEFAULT_AI_SYMBOL)  

        # Assert
        expect(last_response.body).to have_tag('input.row2.col2', :with => { :value => MyApp::DEFAULT_AI_SYMBOL })
      end
    end

    private

    def build_post_data (grid_cells, ai_symbol = MyApp::DEFAULT_AI_SYMBOL) 
      grid_cell_names = [:row0_col0_in, \
                         :row0_col1_in, \
                         :row0_col2_in, \
                         :row1_col0_in, \
                         :row1_col1_in, \
                         :row1_col2_in, \
                         :row2_col0_in, \
                         :row2_col1_in, \
                         :row2_col2_in]
      grid_cells_with_names = Hash.new
      
      for row in 0..2 
        for col in 0..2 
          index = (row*3) + col
          grid_cells_with_names[grid_cell_names[index]] = grid_cells[row][col]
        end
      end

      grid_cells_with_names[:ai_symbol] = ai_symbol

      grid_cells_with_names
    end
end