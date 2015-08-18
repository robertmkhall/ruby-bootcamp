require 'rack/builder'

class Linguine

  ENGLISH = 'en'
  UNKNOWN_URL = 'unknown_url'

  attr_reader :translator, :html_renderer, :default_language

  class << self
    attr_accessor :pages, :html_renderer, :translator
    attr_writer :default_language

    def call env
      new(html_renderer, translator, default_language).call(env)
    end

    def page(*path, &block)
      path.each { |path_arg| pages[path_arg] = block }
    end

    def pages
      @pages ||= {}
      @pages
    end

    def default_language
      @default_language || ENGLISH
    end
  end

  def initialize(html_renderer, translator, default_language)
    @html_renderer = html_renderer
    @translator = translator
    @default_language = default_language
  end

  def call(env)
    path = env['REQUEST_PATH']

    local_extension = local_extension(path)
    adjusted_path = remove_locale_extension(path)

    page_content = page_content(adjusted_path, local_extension)

    ['200', {'Content-Type' => 'text/html'}, [page_content]]
  end

  def page_content(page_id, local_extension)
    if pages[page_id]
      source_content = instance_eval(&pages[page_id])
      local_extension ? translate_page_content(source_content, local_extension) : source_content
    else
      unknown_url(page_id)
    end
  end

  def remove_locale_extension(path)
    path.sub(/\.\w+$/, '')
  end

  def pages
    self.class.pages
  end

  def render(view, args)
    html_renderer.render(view, args)
  end

  def translate_page_content(page_content, local_extension)
    translator.translate(page_content, from: default_language, to: local_extension)
  end

  def local_extension(path)
    path[/\.(\w+$)/, 1]
  end

  def unknown_url(url)
    render(UNKNOWN_URL, {content: "Url '#{url}' is not recognised"})
  end
end