require 'pathname'
require 'json'
require 'rest-client'

class BillingService

  BILLS_QUERY_URI = 'http://localhost:9494/account/:username/bill'
  BILL_REQUEST_URI = 'http://localhost:9494/account/:username/bill/:bill_id'

  attr_reader :request_uri

  def initialize(request_uri = BILLS_QUERY_URI)
    @request_uri = request_uri
  end

  def bill(username)
    current_bill_id = current_bill_id(username)
    current_bill = RestClient.get(BILL_REQUEST_URI.sub(':username', username).sub(':bill_id', current_bill_id))

    JSON.parse(current_bill)
  end

  def bill_ids(username)
    response = RestClient.get(BILLS_QUERY_URI.sub(':username', username))
    JSON.parse(response)['ids']
  end

  def current_bill_id(username)
    bill_ids(username).last
  end
end