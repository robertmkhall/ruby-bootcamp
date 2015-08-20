shared_context :sinatra_application do
  include Rack::Test::Methods

  let(:app_options) {{}}

  def app
    Class.new(described_class, app_options) do |app|
      app.set :show_exceptions, false
      app.set :raise_errors, true
    end
  end
end