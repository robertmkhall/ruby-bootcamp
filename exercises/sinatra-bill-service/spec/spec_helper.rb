require 'bundler'
Bundler.require

require 'rack/test'
require 'fabrication'

$LOAD_PATH.unshift("#{__dir__}/../lib")

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].each {|f| require f}