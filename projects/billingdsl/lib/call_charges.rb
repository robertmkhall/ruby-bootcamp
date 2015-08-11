require 'billingdsl'
require 'call'

class CallCharges

  extend AttributeSupport

  define_attribute :calls

  def initialize(&block)
    instance_eval &block if block_given?
  end

  def call(tel_number, &block)
    @calls ||= []
    @calls << Call.new(tel_number, &block)
  end

  def to_json
    @calls.map(&:to_hash)
  end
end