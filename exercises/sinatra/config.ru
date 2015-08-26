Bundler.require
$LOAD_PATH.unshift("#{__dir__}/lib")

require 'app'

Sinatra::Base.set :root, __dir__

configure(:testing) {
  Bill.billing_service = BillingService.new("#{__dir__}/spec/resources/test_bill.json")
}

map '/' do
  run Login
end

map '/bill' do
  run Bill
end