require 'billingdsl'
require 'call'

class CallCharges < Billingdsl::DSL

  def call(tel_number, &block)
    @attributes[:calls] ||= []
    @attributes[:calls] << Call.new(tel_number, &block)
  end

  def calls
    @attributes[:calls]
  end
end