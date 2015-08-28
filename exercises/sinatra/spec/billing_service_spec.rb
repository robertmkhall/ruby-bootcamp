require 'billing_service'

describe BillingService do

  subject(:billing_service) { described_class.new }
  let(:valid_username) { 'robertmkhall' }
  let(:invalid_username) { 'invalid_username' }

  describe '#bill' do
    let(:expected_bill_ids_response) { "{\"ids\": [\"100000001\", \"10000002\"] }"}
    let(:expected_json) { "{\"name\": \"Some dude\", \"date\": \"01/01/2016\", \"amount\": 999.99}" }
    let(:expected_hash) { {'name' => 'Some dude', 'date' => '01/01/2016', 'amount' => 999.99} }

    before do
      stub_request(:get, Addressable::Template.new(subject.query_uri))
        .to_return({body: expected_bill_ids_response})
      stub_request(:get, Addressable::Template.new(subject.request_uri))
        .to_return({body: expected_json})
    end

    it 'will return the bill as a hash' do
      expect(subject.bill(valid_username)).to eql(expected_hash)
    end
  end
end