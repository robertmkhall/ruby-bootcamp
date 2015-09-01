require 'billing_service'
require 'spec_helper'

describe BillingService do

  include_context :common_data

  subject(:billing_service) { described_class.new }

  describe '#bill' do
    let(:expected_file_content) { "{\"name\": \"Some dude\", \"date\": \"01/01/2016\", \"amount\": 999.99}" }

    before do
      allow(File).to receive(:read).with(BillingService::BILL_PATH).and_return(expected_file_content)
    end

    it 'will return the bill as a hash' do
      expect(subject.bill(valid_bill_id)).to eql(expected_file_content)
    end

    it 'will raise an exception' do
      expect { subject.bill(invalid_bill_id) }.to raise_exception(BillNotFound)
    end
  end

  describe '#bill_ids' do
    let(:expected_bill_ids) { JSON.generate({ids: BillingService::BILL_IDS}) }

    it 'will return an array of bill ids' do
      expect(subject.bill_ids(valid_username)).to eql(expected_bill_ids)
    end

    it 'will raise an exception' do
      expect { subject.bill_ids(invalid_username) }.to raise_exception(BillingAccountNotFound)
    end
  end
end