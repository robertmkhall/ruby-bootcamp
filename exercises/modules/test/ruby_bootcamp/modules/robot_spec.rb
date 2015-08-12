require_relative '../../../lib/ruby_bootcamp/modules/robot'
require 'timecop'

describe RubyBootcamp::Modules::Robot do

  subject(:robot) { described_class.new('') }

  describe '#tell_me_the_time' do
    it 'will output the current time' do

      class RubyBootcamp::Modules::Robot
        def greeting
          'yo'
        end
      end

      expected_time = Time.now
      Timecop.freeze(expected_time)

      expect{subject.tell_me_the_time}.to output("yo, the time is #{expected_time}\n").to_stdout
    end
  end

  describe '#fire_laser' do
    it 'will output firing laser in uppercase' do
      expect{subject.fire_laser}.to output("FIRING LASER!!!\n").to_stdout
    end
  end
end