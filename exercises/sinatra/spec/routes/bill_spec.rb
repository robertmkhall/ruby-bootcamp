require_relative '../spec_helper'
require_relative '../../lib/routes/bill'
require_relative '../../lib/billing_service'


describe Bill do

  include_context :sinatra_application

  let(:app_options) { {billing_service: billing_service} } # overrides app_options passed to Bill.new (see shared context)
  let(:bill_hash) { {name: 'Some dude', date: '01/01/2016', amount: 999.99} }
  let(:billing_service) { BillingService.new }

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

