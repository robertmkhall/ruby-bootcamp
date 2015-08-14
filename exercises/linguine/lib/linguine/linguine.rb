require 'rack/builder'

class Linguine

  class << self
    attr_accessor :pages
  end

  def initialize(translator)
    @translator = translator
  end

  def call(env)
    path = env['REQUEST_PATH']

    ['200', {'Content-Type' => 'text/html'}, [translate_html(path)]]
  end

  def self.page(path, &block)
    Linguine::pages ||= {}
    Linguine::pages[path] = block
  end

  def translate_html(path)
    base_html = Linguine::pages[path] ? Linguine::pages[path].call : unknown_url(path)
    @translator.translate(base_html)
  end

  def unknown_url(path)
    "Unknown url #{path}"
  end
end