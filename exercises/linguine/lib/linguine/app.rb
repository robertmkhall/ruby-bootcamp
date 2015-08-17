require_relative 'linguine'
require 'haml'

class App < Linguine

  class << self
    attr_accessor :html_renderer
  end

  def initialize(html_renderer, translator)
    App::html_renderer = html_renderer
    super(translator)
  end

  page '/' do
    render('index', {heading: 'Welcome To RobCorp'})
  end

  page '/about' do
    render('about', {heading: 'This is the website for RobCorp'})
  end

  def unknown_url(url)
    App::render('unknown_url', {content: "Url '#{url}' is not recognised"})
  end

  def self.render(view, args)
    @html_renderer.render(view, args)
  end
end