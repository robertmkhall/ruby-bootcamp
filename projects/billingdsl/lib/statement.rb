require 'billingdsl'
require 'call_charges'
require 'period'

class Statement < Billingdsl::DSL

  def call_charges(&block)
    if block_given?
      @attributes[:call_charges] = CallCharges.new(&block)
    else
      @attributes[:call_charges]
    end
  end

  def from(date = nil)
    if date
      @attributes[:period] ||= Period.new(&block)
      @attributes[:period].attributes[:from] = date
    else
      @attributes[:period].attributes[:from]
    end
  end

  def to(date = nil)
    if date
      @attributes[:period] ||= Period.new(&block)
      @attributes[:period].attributes[:to] = date
    else
      @attributes[:period].attributes[:to]
    end
  end

  def period(&block)
    if block_given?
      @attributes[:period] = Period.new(&block)
    else
      @attributes[:period]
    end
  end

  def self_to_json(attr, indent_size, indent)
    "{\n" + super + "\n}"
  end
end