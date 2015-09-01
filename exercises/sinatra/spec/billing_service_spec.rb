require 'billing_service'

describe BillingService do

  subject(:billing_service) { described_class.new }
  let(:valid_username) { 'robertmkhall' }
  let(:invalid_username) { 'invalid_username' }

  describe '#bill' do
    let(:expected_bill_ids_response) { "{\"ids\": [\"100000001\", \"10000002\"] }"}
    let(:expected_json) { "{\"name\": \"Some dude\", \"date\": \"01/01/2016\", \"amount\": 999.99}" }

    before do
      stub_request(:get, Addressable::Template.new(subject.query_uri))
        .to_return({body: expected_bill_ids_response})
      stub_request(:get, Addressable::Template.new(subject.request_uri))
        .to_return({body: expected_json})
    end

    it 'will return the bill as a hash' do
      actual_bill = subject.bill(valid_username)
      expect(actual_bill.name).to eq('Some dude')
      expect(actual_bill.date).to eq("01/01/2016")
      expect(actual_bill.amount).to eq(999.99)
    end
  end
end