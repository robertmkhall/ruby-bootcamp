require 'addressable/template'
require 'hashie'

class BillStatement < Hashie::Mash

  def cost
    format_money(self[:cost])
  end

  def total
    format_money(self[:total])
  end

  def format_money(amount)
    Money.new(amount.to_f * 100, 'GBP').format
  end
end

class BillingService

  BASE_URI = 'http://localhost:9393/bill'

  attr_reader :base_uri

  def initialize(base_uri = BASE_URI)
    @base_uri = base_uri
  end

  def query_uri
    "#{base_uri}{?username}"
  end

  def request_uri
    "#{base_uri}/{bill_id}"
  end

  def bill(username)
    current_bill_id = current_bill_id(username)

    translated_url = Addressable::Template.new(request_uri).expand({'bill_id': current_bill_id}).to_s
    current_bill = RestClient.get(translated_url)

    hashed = JSON.parse(current_bill)
    BillStatement.new(hashed)
  end

  def bill_ids(username)
    translated_url = Addressable::Template.new(query_uri).partial_expand({'username': username}).pattern
    response = RestClient.get(translated_url)

    JSON.parse(response)['ids']
  end

  def current_bill_id(username)
    bill_ids(username).last
  end
end