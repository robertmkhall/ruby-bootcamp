require 'sinatra'
require_relative '../../lib/billing_service'

class Bill < Sinatra::Base

  attr_accessor :billing_service

  get '/' do
    slim :bill, locals: billing_service.bill
  end

  def initialize(app = nil, options = {billing_service: BillingService.new})
    super(app)

    @billing_service = options[:billing_service]
  end
end