require 'bundler'
Bundler.require

require 'rack/test'
require 'capybara/rspec'
require 'rspec'
require 'json'
require 'webmock/rspec'

$LOAD_PATH.unshift("#{__dir__}/../lib")

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}