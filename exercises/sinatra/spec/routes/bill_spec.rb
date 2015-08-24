require_relative '../spec_helper'
require_relative '../../lib/routes/bill'
require_relative '../../lib/billing_service'


describe Bill do

  include_context :sinatra_application
  include_context :authentication

  let(:app_options) { {billing_service: billing_service} } # overrides app_options passed to Bill.new (see shared context)
  let(:bill_hash) { {name: 'Some dude', date: '01/01/2016', amount: 999.99} }
  let(:billing_service) { BillingService.new }

  before do
    allow(billing_service).to receive(:bill).and_return(bill_hash)
  end

  describe 'get /' do
    context 'user already logged in' do
      before do
        allow_any_instance_of(described_class).to receive(:logged_in).and_return(true)
      end

      it 'renders the bill' do
        expect_any_instance_of(described_class).to receive(:slim).with(:bill, locals: {bill: bill_hash})

        get('/')
      end
    end

    context 'user not logged in' do
      it 'renders the bill' do
        get('/')

        expect(last_response).to redirect_to('/login')
      end
    end
  end
end

