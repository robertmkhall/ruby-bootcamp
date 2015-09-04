require 'bundler'
Bundler.require

$LOAD_PATH.unshift("#{__dir__}/../lib")

require 'oauth'
require 'rspec'
require 'capybara/rspec'
require 'rack/test'
require 'dotenv'

Dotenv.load

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}