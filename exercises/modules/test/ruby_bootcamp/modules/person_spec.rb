require_relative '../../../lib/ruby_bootcamp/modules/person'
require 'timecop'

describe RubyBootcamp::Modules::Person do

  describe '#tell_me_the_time' do
    class RubyBootcamp::Modules::Person
      def greeting
        'hello'
      end
    end

    it 'will not output the time' do
      person = RubyBootcamp::Modules::Person.new('')

      expect { person.tell_me_the_time }.to output("hello, sorry i'm not a robot and i don't have a watch\n").to_stdout
    end
  end
end