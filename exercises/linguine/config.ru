require_relative 'lib/linguine/app.rb'
require_relative 'lib/linguine/haml_renderer'
require_relative 'lib/linguine/bing_translator'


App.translator = BingTranslator.new
App.html_renderer = HamlRenderer.new
App.default_language = Linguine::ENGLISH


run App