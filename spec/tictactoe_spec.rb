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
      grid_cells = {
        :row1_col1_in => 'input.row1.col1',
        :row2_col1_in => 'input.row2.col1',
        :row3_col1_in => 'input.row3.col1',
        :row1_col2_in => 'input.row1.col2',
        :row2_col2_in => 'input.row2.col2',
        :row3_col2_in => 'input.row3.col2',
        :row1_col3_in => 'input.row1.col3',
        :row2_col3_in => 'input.row2.col3',
        :row3_col3_in => 'input.row3.col3'
      }

      grid_cells.each do |input, css|
        it "remembers when user plays O or X" do
          post "/tictactoe", input => "X" 
          expect(last_response).to be_ok
          expect(last_response.body).to have_tag(css, :value => 'X')
        end
      end
    end
end