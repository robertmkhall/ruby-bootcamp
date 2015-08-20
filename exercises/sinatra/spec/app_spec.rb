require 'rspec'
require 'rack/test'
require 'sinatra'

def app
  Sinatra::Application
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

describe 'login via web request' do
  let(:valid_username) { 'robertmkhall' }
  let(:valid_password) { 'password' }
  let(:invalid_username) { 'invalid_username' }
  let(:invalid_password) { 'invalid_password' }

  it 'will output json on valid credentials' do
    post('/login', username: valid_username, password: valid_password)

    expect(last_response.headers['Content-Type']).to eq('application/json')
  end
end


# Slim::Engine.new(File.read('')).render(self.locals)