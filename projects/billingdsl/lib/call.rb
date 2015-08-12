require 'billingdsl'
require 'json'

class Call < Billingdsl::DSL

  define_attribute :called
  define_attribute :date
  define_attribute :duration
  define_attribute :cost

  def initialize(called, &block)
    @called = called

    super(&block)
  end
end