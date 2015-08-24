require_relative '../../lib/routes/login'
require_relative '../spec_helper'

describe Login do

  include_context :sinatra_application
  include_context :authentication

  let(:app_options) { {authenticator: authenticator} } # overrides app_options passed to Login.new (see shared context)
  let(:authenticator) { Authenticator.new }

  describe 'get /' do
    context 'no previous logins' do
      it 'renders the login page' do
        expect_any_instance_of(described_class).to receive(:slim).with(:login)

        get '/login'
      end

      it 'redirects to the login page' do
        get '/'

        expect(last_response).to redirect_to('/login')
      end
    end

    context 'user already logged in' do
      before do
        # Simulate previous login
        post '/login', username: valid_username, password: valid_password
      end

      it 'redirects to the bill page' do
        get '/'

        expect(last_response).to redirect_to('/bill')
      end
    end
  end

  describe 'post /' do
    before do
      allow(authenticator).to receive(:authenticate).with(valid_username, valid_password).and_return(true)
      allow(authenticator).to receive(:authenticate).with(valid_username, invalid_password).and_return(false)
    end

    it 'redirects to the bill page' do
      post '/login', username: valid_username, password: valid_password

      expect(last_response).to redirect_to('/bill')
    end

    it 'redirects to the login page' do
      post '/login', username: valid_username, password: invalid_password

      expect(last_response).to redirect_to('/')
    end
  end
end