require 'sinatra'
require 'billing_service'

class App < Sinatra::Base

  attr_reader :billing_service

  def initialize(options ={billing_service: BillingService.new})
    super

    @billing_service = options[:billing_service]
  end

  get '/bill' do
    begin
      billing_service.bill_ids(params[:username])
    rescue BillingAccountNotFound
      raise Sinatra::NotFound
    end
  end

  get '/bill/:bill_id' do
    begin
      billing_service.bill(params[:bill_id])
    rescue BillNotFound
      raise Sinatra::NotFound
    end
  end
end