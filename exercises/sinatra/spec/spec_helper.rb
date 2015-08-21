# $LOAD_PATH.unshift("#{__dir__}/../lib")
require 'rack/test'
require 'capybara/rspec'

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}