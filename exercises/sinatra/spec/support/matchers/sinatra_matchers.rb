RSpec::Matchers.define :redirect_to do |path|
  match do |last_response|
    last_response.status == 302 && last_response.headers['location'].end_with?(path)
  end
end