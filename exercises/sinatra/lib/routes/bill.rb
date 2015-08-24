require 'sinatra'
require_relative '../../lib/billing_service'
require 'support/helpers'

class Bill < Sinatra::Base

  attr_reader :billing_service

  register Sinatra::SessionAuth

  get '/' do
    check_login { slim :bill, locals: { bill: billing_service.bill } }
  end

  def initialize(options = {billing_service: BillingService.new})
    super

    @billing_service = options[:billing_service]
  end
end