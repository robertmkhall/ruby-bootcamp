require 'bundler'
Bundler.require

require 'rack/test'
require 'capybara/rspec'
require 'rspec'
require 'json'
require 'pact'
require 'pact/consumer/rspec'

$LOAD_PATH.unshift("#{__dir__}/../lib")

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}

Pact.service_consumer 'Bill Service Consumer' do
  has_pact_with 'Bill Service Producer' do
    mock_service :bill_service_producer do
      port 9393
    end
  end
end