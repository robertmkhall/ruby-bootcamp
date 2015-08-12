require 'billingdsl'
require 'call_charges'
require 'json'

class Statement < Billingdsl::DSL
  extend AttributeSupport

  define_attribute :call_charges
  define_attribute :date
  define_attribute :due
  define_attribute :from
  define_attribute :to

  def call_charges(&block)
    if block_given?
      @call_charges = CallCharges.new(&block)
    else
      @call_charges
    end
  end

  def total
    @call_charges.calls.inject(0) {|result, call| result + call.cost}
  end

  def to_hash
    {statement: {
        date: @date,
        due: @due,
        period: {
            from: @from,
            to: @to
        },
        total: total.round(2),
        callCharges: {
            calls: @call_charges.to_hash
        }
    }}
  end

  def to_json
    JSON.pretty_generate(to_hash)
  end
end

class Fixnum
  def days
    self
  end
end