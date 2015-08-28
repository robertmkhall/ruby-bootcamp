require_relative 'spec_helper'
require 'app'
require 'billing_service'

describe App do

  include_context :sinatra_application
  include_context :common_data

  let(:billing_service) { BillingService.new }
  let(:app_options) { {billing_service: billing_service} }
  let(:expected_bill_response) { JSON.generate(name: 'Some dude', date: '01/01/2016', amount: 999.99) }

  describe 'get /bill/:bill_id' do
    before do
      allow(billing_service).to receive(:bill).with(valid_bill_id).and_return(expected_bill_response)
      allow(billing_service).to receive(:bill).with(invalid_bill_id).and_raise(BillNotFound)
    end

    # context 'valid data' do
    #
    #   let(:bill) { Fabricate(:bill_valid) }
    #   let(:bill_id) { bill.id }
    #
    #   it 'return the bill as json' do
    #     expect(last_response.body).to eql(bill.to_json)
    #   end
    #
    # end
    #
    # context 'invalid data' do
    #
    #   let(:bill) { Fabricate(:bill_valid) }
    #   let(:bill_id) { bill.id }
    #
    #   it 'return the bill as json' do
    #     expect(last_response.body).to eql(bill.to_json)
    #   end
    #
    # end

    it 'returns a 404' do
      get "/bill/#{invalid_bill_id}"

      expect(last_response.status).to eql(404)
    end
  end

  describe 'get /bill/:username' do
    before do
      allow(billing_service).to receive(:bill_ids).with(valid_username).and_return(bill_ids_response)
      allow(billing_service).to receive(:bill_ids).with(invalid_username).and_raise(BillingAccountNotFound)
    end

    it 'returns array of bill ids' do
      get '/bill', params = {username: valid_username}

      expect(last_response.body).to eql(bill_ids_response)
    end

    it 'returns a 404' do
      get '/bill', params = {username: invalid_username}

      expect(last_response.status).to eql(404)
    end
  end
end