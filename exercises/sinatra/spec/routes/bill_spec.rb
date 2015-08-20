require 'rspec'
require 'rack/test'
require 'sinatra'
require_relative '../../lib/routes/bill'
require_relative '../contexts/sinatra_application_context'
require_relative '../../lib/billing_service'

# §

# describe 'login via web request' do
#
#   let(:valid_username) { 'robertmkhall' }
#   let(:valid_password) { 'password' }
#   let(:invalid_username) { 'invalid_username' }
#   let(:invalid_password) { 'invalid_password' }
#
#   it 'will output json on valid credentials' do
#     post('/login', username: valid_username, password: valid_password)
#
#     expect(last_response.headers['Content-Type']).to eq('application/json')
#   end
# end

describe Bill do

  include_context :sinatra_application

  let(:bill_hash) {{name: 'Some dude', date: '01/01/2016', amount: 999.99}}
  let(:billing_service) {BillingService.new}
  let(:app_options) {billing_service}

  before do
    allow(billing_service).to receive(:bill).and_return(bill_hash)
  end

  describe 'get /' do
    it 'renders the bill' do
      expect_any_instance_of(described_class).to receive(:slim).with(:bill, locals: bill_hash)

      get('/')
    end
  end
end

