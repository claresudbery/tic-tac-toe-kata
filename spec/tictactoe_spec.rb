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
        get '/tictactoe'
        expect(last_response).to be_ok
        expect(last_response.body).to have_tag('input', :with => { :class => 'row1 col1' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row1 col2' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row1 col3' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row2 col1' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row2 col2' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row2 col3' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row3 col1' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row3 col2' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row3 col3' })
      end
    end
  
    context "post /tictactoe" do
      grid_cells_with_css = {
        :row1_col1_in => {:css => 'input.row1.col1', :input => "A"},
        :row2_col1_in => {:css => 'input.row2.col1', :input => "B"},
        :row3_col1_in => {:css => 'input.row3.col1', :input => "C"},
        :row1_col2_in => {:css => 'input.row1.col2', :input => "D"},
        :row2_col2_in => {:css => 'input.row2.col2', :input => "E"},
        :row3_col2_in => {:css => 'input.row3.col2', :input => "F"},
        :row1_col3_in => {:css => 'input.row1.col3', :input => "G"},
        :row2_col3_in => {:css => 'input.row2.col3', :input => "H"},
        :row3_col3_in => {:css => 'input.row3.col3', :input => "I"}
      }

      grid_cells_with_css.each do |control, values|
        it "remembers when user makes a mark in a grid cell" do
          post "/tictactoe", control => values[:input] 
          expect(last_response).to be_ok
          expect(last_response.body).to have_tag(values[:css], :with => { :value => values[:input] })
        end
      end

      grid_cells = Hash[*grid_cells_with_css.map{ |k,v| [k, v[:input]] }.flatten]

      it "remembers data from previous sessions" do        
        post "/tictactoe", grid_cells 
        
        get '/tictactoe'
        get '/tictactoe'
        grid_cells_with_css.each do |control, values|
          expect(last_response.body).to have_tag(values[:css], :with => { :value => values[:input] })
        end
      end
    end
end