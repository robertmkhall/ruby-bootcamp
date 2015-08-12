require_relative '../../../lib/ruby_bootcamp/modules/sensory'
require_relative '../../../lib/ruby_bootcamp/modules/person'
require_relative '../../../lib/ruby_bootcamp/modules/robot'

RSpec.shared_examples 'a vocaliser' do
  let(:vocaliser) { described_class.new('') }

  describe '#say' do
    it 'will output message in lowercase' do
      expect { vocaliser.say('Something Funny') }.to output("something funny\n").to_stdout
    end
  end

  describe '#shout' do
    it 'will output message in uppercase' do
      expect { vocaliser.shout('Something Funny') }.to output("SOMETHING FUNNY!!!\n").to_stdout
    end
  end

  describe 'greeting' do
    it 'will return a sample of the available greetings' do
      expect(Vocaliser::DEFAULT_GREETINGS).to include(vocaliser.greeting)
    end
  end

  describe 'farewell' do
    it 'will return a sample of the available greetings' do
      expect(Vocaliser::DEFAULT_GOODBYES).to include(vocaliser.farewell)
    end
  end

  describe 'is a vocaliser' do
    it 'will be a vocaliser' do
      expect(vocaliser.kind_of?(Vocaliser)).to eql(true)
    end
  end
end

RSpec.shared_examples 'a mover' do
  let(:mover) { described_class.new('') }

  describe '#move_left' do
    it 'will update the new position' do
      mover.move_left

      expect(mover.position).to eql({:logitude => 0, :lattitude => 1})
    end
  end

  describe '#move_right' do
    it 'will update the new position' do
      mover.move_right

      expect(mover.position).to eql({:logitude => 0, :lattitude => -1})
    end
  end

  describe '#move_forwards' do
    it 'will update the new position' do
      mover.move_forwards

      expect(mover.position).to eql({:logitude => 1, :lattitude => 0})
    end
  end

  describe '#move_backwards' do
    it 'will update the new position' do
      mover.move_backwards

      expect(mover.position).to eql({:logitude => -1, :lattitude => 0})
    end
  end

  describe '#move' do
    it 'will update the new position' do
      mover.move(:left)
      mover.move(:forwards)
      mover.move(:left)
      mover.move(:right)
      mover.move(:backwards)

      expect(mover.position).to eql({:logitude => 0, :lattitude => 1})
    end

    it 'will raise an exception' do
      expect{mover.move(:invalid_move)}.to raise_exception(Mover::InvalidDirectionException,
                                                           "I just don't move like that")
    end
  end

  describe 'is a mover' do
    it 'will be a mover' do
      expect(mover.kind_of?(Mover)).to eql(true)
    end
  end
end

RSpec.describe RubyBootcamp::Modules::Person do
  it_behaves_like 'a vocaliser'
  it_behaves_like 'a mover'
end

RSpec.describe RubyBootcamp::Modules::Robot do
  it_behaves_like 'a vocaliser'
  it_behaves_like 'a mover'
end

