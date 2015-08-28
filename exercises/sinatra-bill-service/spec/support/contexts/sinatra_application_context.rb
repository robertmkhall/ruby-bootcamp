shared_context :sinatra_application do
  include Rack::Test::Methods

  let(:app_options) {{}}

  def app
    clazz = Class.new(described_class) do |app|
      app.set :show_exceptions, false
      app.set :raise_errors, true
    end
    clazz.new(app_options)
  end
end