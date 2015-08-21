require_relative '../../lib/routes/login'
require_relative '../spec_helper'

describe Login do

  include_context :sinatra_application

  let(:app_options) { {authenticator: authenticator} } # overrides app_options passed to Login.new (see shared context)
  let(:authenticator) { Authenticator.new }

  let(:valid_username) { 'robertmkhall' }
  let(:valid_password) { 'password' }
  let(:invalid_password) { 'invalid_password' }

  describe 'get /' do
    it 'renders the login page' do
      expect_any_instance_of(described_class).to receive(:slim).with(:login)

      get '/'
    end
  end

  describe 'post /' do
    before do
      allow(authenticator).to receive(:authenticate).with(valid_username, valid_password).and_return(true)
      allow(authenticator).to receive(:authenticate).with(valid_username, invalid_password).and_return(false)
    end

    it 'redirects to the bill page' do
      post '/', username: valid_username, password: valid_password

      expect(last_response).to redirect_to('/bill')
    end

    it 'redirects to the login page' do
      post '/', username: valid_username, password: invalid_password

      expect(last_response).to redirect_to('/login')
    end
  end
end