require_relative 'sensory'

module RubyBootcamp
  module Modules
    class Person
      include Vocaliser, Mover

      def initialize(name)
        @name = name
      end

      def tell_me_the_time
        say "#{greeting}, sorry I'm not a Robot and I don't have a watch"
      end
    end
  end
end
