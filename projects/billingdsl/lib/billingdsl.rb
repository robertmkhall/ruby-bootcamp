require "billingdsl/version"

module Billingdsl

  class DSL
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

    def to_json
      json_array = @attributes.each_key.inject("") do |result, attr_key|
        attr = @attributes[attr_key]
        result + (attr.is_a?(DSL) ? attr.to_json : DSL.to_json(attr_key, attr))
      end
      "{\n  \"#{self.class.name}\": {\n" + json_array.to_s
    end

    def self.to_json(attr_key, attr)
      "    \"#{attr_key}\": \"#{attr.to_s}\",\n"
    end
  end
end
