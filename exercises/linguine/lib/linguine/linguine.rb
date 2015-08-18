require 'rack/builder'

class Linguine

  DEFAULT_HTML_LANG = 'en'
  UNKNOWN_URL = 'unknown_url'

  attr_reader :translator

  class << self
    attr_accessor :pages, :html_renderer

    def page(*path, &block)
      path.each {|path_arg| pages[path_arg] = block}
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

  def translate_html(path)
    language_code = language_code(path)
    default_html = default_html(path, language_code)

    if default_html
      language_code.empty? ? default_html : translator.translate(default_html, DEFAULT_HTML_LANG, language_code)
    else
      unknown_url(path)
    end
  end

  def default_html(path, language_code)
    adjusted_path = path.sub(".#{language_code}", '')
    pages[adjusted_path].call if pages[adjusted_path]
  end

  def language_code(path)
    File.extname(path).sub('.', '')
  end

  def unknown_url(url)
    render(UNKNOWN_URL, {content: "Url '#{url}' is not recognised"})
  end
end