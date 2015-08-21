require 'rspec'
require 'json'
require_relative '../lib/billing_service'

describe BillingService do

  subject(:billing_service) { described_class.new }
  let(:valid_username) { 'robertmkhall' }
  let(:invalid_username) { 'invalid_username' }

  describe '#bill' do
    let(:expected_file_content) { "{\"name\": \"Some dude\", \"date\": \"01/01/2016\", \"amount\": 999.99}" }
    let(:expected_hash) { {'name' => 'Some dude', 'date' => '01/01/2016', 'amount' => 999.99} }

    before do
      allow(File).to receive(:read).with(BillingService::BILL_PATH).and_return(expected_file_content)
    end

    it 'will return the bill as a hash' do
      expect(subject.bill).to eql(expected_hash)
    end
  end
end