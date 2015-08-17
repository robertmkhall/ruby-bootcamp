require 'rack/builder'

class Linguine

  DEFAULT_HTML_LANG = 'en'

  class << self
    attr_accessor :pages, :html_renderer

    def page(path, &block)
      pages[path] = block
    end

    def pages
      @pages ||= {}
      @pages
    end

    def render(view, args)
      @html_renderer.render(view, args)
    end
  end

  def initialize(html_renderer, translator)
    self.class.html_renderer = html_renderer
    @translator = translator
  end

  def call(env)
    path = env['REQUEST_PATH']

    ['200', {'Content-Type' => 'text/html'}, [translate_html(path)]]
  end

  def pages
    self.class.pages
  end

  def render(view, args)
    self.class.render(view, args)
  end

  #todo break up this method
  def translate_html(path)
    language_code = language_code(path)
    adjusted_path = path.sub(".#{language_code}", '')

    known_path = pages[adjusted_path]
    base_html = known_path ? pages[adjusted_path].call : unknown_url(adjusted_path)
    language_code.empty? || !known_path ? base_html : @translator.translate(base_html, DEFAULT_HTML_LANG, language_code)
  end

  def language_code(path)
    File.extname(path).sub('.', '')
  end

  def unknown_url(path)
    "Unknown url #{path}"
  end
end