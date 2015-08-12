require 'billingdsl'
require 'call'

class CallCharges < Billingdsl::DSL

  define_attribute :calls

  def call(tel_number, &block)
    @calls ||= []
    @calls << Call.new(tel_number, &block)
  end

  def to_hash
    @calls.map(&:to_hash)
  end
end