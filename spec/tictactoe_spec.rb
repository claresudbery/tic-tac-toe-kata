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
  
    it "says hello to the world" do
      get '/tictactoe'
      expect(last_response).to be_ok
      expect(last_response.body).to include('Hello World')
    end
end