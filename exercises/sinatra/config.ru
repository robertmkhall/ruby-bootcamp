$LOAD_PATH.unshift("#{__dir__}/lib/sinatra")

require 'app'

Sinatra::Base.set :root, __dir__

map '/login' do
  run Login
end

map '/bill' do
  run Bill
end
# require_relative 'lib/sinatra/app'
# require 'lib/sinatra/authenticator'
# require 'lib/sinatra/billing_service'
#
# app = App.new(Authenticator.new, BillingService.new)
# run app

# App.authenticator = Authenticator.new
# App.billing_service = BillingService.new
# run App
