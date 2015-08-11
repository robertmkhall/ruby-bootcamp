require 'billingdsl'
require 'json'

class Call < Billingdsl::DSL

  def initialize(tel_number, &block)
    @attributes ||= {}
    @attributes[:called] = tel_number

    instance_eval &block if block_given?
  end

  def called
    @attributes[:called]
  end

  def self_to_json(attr, indent_size, indent)
    attr.to_json('', attr.attributes, indent_size + 2)
  end

  def to_json(attr_key = self.class.name, attr = self, indent_size = 2)
    indent = indent(indent_size)
    json = indent + "{"

    json += attr.keys.inject("") do |result, sym|
      result += "," unless result.empty?
      result + super(sym, attr[sym], 1)
    end

    json += " }"
    json
  end
end