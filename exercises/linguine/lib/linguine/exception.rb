class HtmlRenderingException < RuntimeError

  def initialize(view)
    super("Problem encountered whilst rendering view '#{view}'")
  end
end