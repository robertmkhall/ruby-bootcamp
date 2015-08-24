require 'sinatra'
require_relative '../authenticator'
require 'support/helpers'

class Login < Sinatra::Base

  attr_reader :authenticator

  register Sinatra::SessionAuth

  get '/' do
    check_login { redirect '/bill' }
  end

  get '/login' do
    slim :login
  end

  post '/login' do
    redirect '/bill' if authenticated
    redirect '/'
  end

  def initialize(options = {authenticator: Authenticator.new})
    super

    @authenticator = options[:authenticator]
  end

  def authenticated
    authenticated = authenticator.authenticate(params[:username], params[:password])
    session[:username] = params[:username] if authenticated

    authenticated
  end
end