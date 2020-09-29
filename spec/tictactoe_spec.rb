ENV['APP_ENV'] = 'test'

require "spec_helper"

require_relative '../tictactoe'
require 'rspec'
require 'rack/test'

RSpec.describe 'The HelloWorld App' do
    include Rack::Test::Methods
  
    def app
      MyApp
    end
  
    context "get /tictactoe" do  
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
  
    context "post /tictactoe and /reset" do
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

      grid_cells = Hash[*grid_cells_with_css.map{ |k,v| [k, v[:input]] }.flatten]

      it "remembers data from previous sessions" do   
        # Arrange
        post "/tictactoe", grid_cells         
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
        post "/tictactoe", grid_cells  
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
end