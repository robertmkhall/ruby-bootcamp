require 'haml'
require_relative 'exception'

class HamlRenderer

  def initialize(base_dir = 'lib')
    @base_dir = base_dir
  end

  def render(view, args)
    view_path = "#{@base_dir}/resources/views/#{view}.haml"

    raise HtmlRenderingException.new("View file does not exist at '#{view_path}'") unless File.exists? view_path

    template = File.open(view_path).read
    engine = Haml::Engine.new(template)
    engine.render(Object.new, args)
  end
end