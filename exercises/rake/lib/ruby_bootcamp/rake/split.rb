module RubyBootcamp
  module Rake
    class Split
      attr_reader :upper, :lower
      attr_accessor :value

      def initialize(lower, upper, value)
        @upper = upper
        @lower = lower
        @value = value
      end

      def ==(other)
        other.is_a?(Split) && other.lower == lower && other.upper == upper
      end
    end
  end
end
