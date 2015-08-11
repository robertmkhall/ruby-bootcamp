require "billingdsl/version"
require 'json'


module Billingdsl

  class DSL

    attr_accessor :attributes

    def initialize(&block)
      @attributes ||= {}

      instance_eval &block if block_given?
    end

    def method_missing(meth, *args, &block)
      @attributes ||= {}

      adjustedName = args.empty? ? meth : meth.to_s + '='

      clazz = class << self;
        self;
      end
      clazz.class_eval do
        if args.empty?
          create_getter meth
        else
          create_setter meth
        end
      end

      send(adjustedName, *args, &block)
    end

    def self.create_setter(meth)
      adjusted_meth = meth.to_s + '='
      define_method(adjusted_meth) do |arg|
        @attributes[meth] = arg
      end
    end

    def self.create_getter(meth)
      define_method(meth) do
        @attributes[meth]
      end
    end


    # def to_json(indent_size = 2)
    #   @indent_size = indent_size
    #   indent = DSL.indent(@indent_size)
    #
    #   json = @attributes.each_key.inject("") do |result, attr_key|
    #     attr = @attributes[attr_key]
    #     result += ",\n" unless result.empty?
    #
    #     result + (attr.is_a?(DSL) ? attr.to_json(@indent_size + 2) : indent + DSL.to_json(attr_key, attr))
    #   end
    #
    #   indent + "\"#{self.class.name.camelize(:lower)}\": {\n" + json.to_s + "\n" + indent + '}'
    # end
    #
    # def self.to_json(attr_key, attr)
    #   attr_key_json = "  \"#{attr_key}\": "
    #   attr_json = attr.is_a?(Float) ? attr.to_s : "\"#{attr.to_s}\""
    #   attr_key_json + attr_json
    # end

    def self_to_json(attr, indent_size, indent)
      indent + "\"#{attr.class.name.camelize(:lower)}\": {\n" + attr.to_json('', attr.attributes, indent_size + 2) + "\n" + indent + '}'
    end

    def to_json(attr_key = self.class.name, attr = self, indent_size = 2)
      indent = indent(indent_size)

      case attr
        when DSL
          attr.self_to_json(attr, indent_size, indent)
        when Hash
          attr.keys.inject("") do |result, sym|
                result += ",\n" unless result.empty?
                result + to_json(sym, attr[sym], indent_size)
          end
        when Array
          array_json = attr.inject("") do |result, val|
            result += ",\n" unless result.empty?
            result + to_json(val.class, val, indent_size)
          end
          indent + "\"#{attr_key}\": [\n" + array_json + "\n" + indent + ']'
        else
          indent + "\"#{attr_key}\": " + attribute_to_json(attr)
      end
    end

    def attribute_to_json(attr)
      case attr
        when Float || Fixnum
          "%.2f" %  attr.to_s
        else
          "\"#{attr.to_s}\""
      end
    end

    def indent(indent_size)
      ' ' * indent_size
    end
  end
end
