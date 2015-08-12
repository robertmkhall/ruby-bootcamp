require "billingdsl/version"

module AttributeSupport

  def define_attribute(name)
    define_method(name) do |*args|
      attribute = "@#{name}"

      if args.empty?
        self.instance_variable_get(attribute)
      else
        self.instance_variable_set(attribute, args.first)
      end
    end
  end

end

module Billingdsl

  class DSL
    extend AttributeSupport

    def initialize(&block)
      instance_eval &block if block_given?
    end

    def to_hash(obj = self)
      obj.instance_variables.each_with_object({}) do |var, hash|
        hash[var.to_s.delete("@").to_sym] = obj.instance_variable_get(var)
      end
    end
  end
end
