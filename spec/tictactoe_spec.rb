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
        expect(last_response.body).to have_tag('input', :with => { :class => 'row0 col0' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row0 col1' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row0 col2' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row1 col0' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row1 col1' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row1 col2' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row2 col0' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row2 col1' })
        expect(last_response.body).to have_tag('input', :with => { :class => 'row2 col2' })
      end
    end
  
    context "post /tictactoe" do
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
          clear_cookies     
          post "/tictactoe", control => values[:input] 
          expect(last_response).to be_ok
          expect(last_response.body).to have_tag(values[:css], :with => { :value => values[:input] })
        end
      end

      grid_cells = Hash[*grid_cells_with_css.map{ |k,v| [k, v[:input]] }.flatten]

      it "remembers data from previous sessions" do   
        clear_cookies     
        post "/tictactoe", grid_cells 
        
        get '/tictactoe'
        get '/tictactoe'
        grid_cells_with_css.each do |control, values|
          expect(last_response.body).to have_tag(values[:css], :with => { :value => values[:input] })
        end
      end
    end
end