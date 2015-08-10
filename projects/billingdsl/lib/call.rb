require 'billingdsl'

class Call < Billingdsl::DSL

  attr_accessor :tel_number

  def initialize(tel_number, &block)
    @tel_number = tel_number

    instance_eval &block if block_given?
  end
end