Bundler.require
$LOAD_PATH.unshift("#{__dir__}/lib")

require 'app'

Sinatra::Base.set :root, __dir__

I18n.enforce_available_locales = false

configure(:testing) {
  Bill.billing_service = BillingService.new("http://localhost:9494/bill")
}

# currency = Money::Currency.new("GBP")
# currency.separator = '.'
# Money.default_currency = currency

map '/' do
  run Login
end

map '/bill' do
  run Bill
end