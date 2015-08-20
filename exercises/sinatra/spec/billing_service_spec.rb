require 'rspec'
require 'json'
require_relative '../lib/billing_service'

describe BillingService do

  subject(:billing_service) {described_class.new}
  let(:valid_username) { 'robertmkhall' }
  let(:invalid_username) { 'invalid_username' }

  it 'will return the bill as a hash' do
    file = File.read('resources/bill.json')
    expected_hash = JSON.parse(file)

    expect(subject.bill(valid_username)).to eql(expected_hash)
  end

  # it 'will raise an exception' do
  #   expect(subject.bill(invalid_username)).to raise_exception(AccountNotFoundException)
  # end
end