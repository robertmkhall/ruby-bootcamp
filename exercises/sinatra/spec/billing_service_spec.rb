require 'billing_service'

describe BillingService do

  subject(:billing_service) { described_class.new }
  let(:valid_username) { Faker::Internet.user_name }
  let(:invalid_username) { 'invalid_username' }

  let(:expected_bill_ids_response) { "{\"ids\":[\"10000001\",\"10000002\"]}" }
  let(:expected_json) do
    ROOT = Pathname.new(File.expand_path(__dir__))
    BILL_PATH = ROOT.join("resources").join('test_bill.json').to_s

    File.read(BILL_PATH)
  end

  describe '#bill', :pact => true do
    before do
      bill_service_producer
          .upon_receiving('a request for bill ids')
          .with({
                    method: :get,
                    path: '/bill',
                    query: URI::encode("username=#{valid_username}")
                })
          .will_respond_with({
                                 status: 200,
                                 body: expected_bill_ids_response
                             })

      bill_service_producer
          .upon_receiving('a request for a specific bill')
          .with({
                    method: :get,
                    path: '/bill/10000002'
                })
          .will_respond_with({
                                 status: 200,
                                 body: expected_json
                             })
    end

    it 'will return the bill as a hash' do
      actual_bill = subject.bill(valid_username)
      expect(actual_bill).to eq(JSON.parse(expected_json))
    end
  end
end