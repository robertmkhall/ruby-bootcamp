require_relative 'lib/linguine/app.rb'
require_relative 'lib/linguine/haml_renderer'
require_relative 'lib/linguine/bing_translator'


run App.new(HamlRenderer.new, BingTranslator.new)