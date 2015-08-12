require_relative 'sensory'

module RubyBootcamp
  module Modules
    class Robot
      include Vocaliser, Mover

      def initialize(name)
        @name = name
      end

      def tell_me_the_time
        say "#{greeting}, the time is #{Time.now}"
      end

      def fire_laser
        shout 'firing laser'
      end
    end
  end
end