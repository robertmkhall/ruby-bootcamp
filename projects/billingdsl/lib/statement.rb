require 'billingdsl'
require 'call_charges'

class Statement < Billingdsl::DSL

  def initialize(&block)
    instance_eval &block if block_given?
  end

  def call_charges(&block)
    if block_given?
      @attributes[:call_charges] = CallCharges.new(&block)
    else
      @attributes[:call_charges]
    end
  end
end