require 'sinatra'
require_relative '../../lib/billing_service'
require 'support/helpers'

class Bill < Sinatra::Base

  attr_reader :billing_service

  register Sinatra::SessionAuth

  class << self
    attr_writer :billing_service

    def billing_service
      @billing_service ||= BillingService.new
    end

    def call env
      new({billing_service: billing_service}).call(env)
    end
  end

  get '/' do
    check_login { slim :bill, locals: {bill: billing_service.bill(username)} }
  end

  def initialize(options = {billing_service: Bill.billing_service})
    super

    @billing_service = options[:billing_service]
  end
end