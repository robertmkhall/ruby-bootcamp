require 'slim'

shared_context :slim_templates do

  def templates_dir
    "#{__dir__}/../../../views/"
  end

  def render locals={}
    result = Slim::Template.new("#{templates_dir}/#{self.class.top_level_description}").render(self,locals)
    PageMagic::Session.new(Capybara::Node::Simple.new(result))
  end
end