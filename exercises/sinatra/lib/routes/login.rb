require 'sinatra'
require_relative '../authenticator'

class Login < Sinatra::Base

  attr_reader :authenticator

  get '/' do
    slim :login
  end

  post '/' do
    redirect '/bill' if authenticate
    redirect '/login'
  end

  def initialize(options = {authenticator: Authenticator.new})
    super

    @authenticator = options[:authenticator]
  end

  def authenticate
    authenticator.authenticate(params[:username], params[:password])
  end
end