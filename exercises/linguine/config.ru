require_relative 'lib/linguine/app.rb'
require_relative 'lib/linguine/haml_renderer'


run App.new(HamlRenderer.new)