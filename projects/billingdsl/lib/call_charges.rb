require 'billingdsl'
require 'call'

class CallCharges < Billingdsl::DSL

  def initialize(&block)
    @attributes ||= {}

    instance_eval &block if block_given?
  end

  def call(tel_number, &block)
    @attributes[:calls] ||= []
    @attributes[:calls] << Call.new(tel_number, &block)
  end

  def calls
    @attributes[:calls]
  end
end