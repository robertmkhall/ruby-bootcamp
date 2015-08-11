require "billingdsl/version"
require 'json'

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

    START_BRACE = '{'
    END_BRACE = '}'

    def initialize(&block)
      instance_eval &block if block_given?
    end

    define_attribute :date

    def json_prefix
      "\"#{self.class.name}\""
    end

    # def to_json
    #   # json_prefix
    #   json_prefix + JSON.pretty_generate(to_hash, opts = {space: ' ', space_before: ' ', indent: ' '})
    # end

    def to_hash(obj = self)
      obj.instance_variables.each_with_object({}) do |var, hash|
        val = obj.instance_variable_get(var)
        hash[var.to_s.delete("@")] = hash_attribute(val)
      end
    end

    def hash_attribute(attr_val)
      case attr_val
        when DSL
          attr_val.to_hash
        # when Array
        #   to_hash(attr)
        else
          attr_val
      end
    end
  end
end
