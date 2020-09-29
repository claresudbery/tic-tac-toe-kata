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