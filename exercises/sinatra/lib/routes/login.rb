require 'sinatra'
require_relative '../authenticator'

class Login < Sinatra::Base

  attr_accessor :authenticator

  get '/' do
    slim :login
  end

  post '/' do
    redirect '/bill' if authenticate
    redirect '/login'
  end


  get '/failed_login' do
    'Failed login'
  end


  def authenticator
    @authenticator ||= Authenticator.new # todo inject dependencies
  end

  def authenticate
    authenticator.authenticate(params[:username], params[:password])
  end
end