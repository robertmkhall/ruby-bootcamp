require_relative '../lib/play'

describe Play do
  describe '#<=>' do
    context 'plays are different' do
      it 'paper compared to rock' do
        expect(Play.new('paper').<=>(Play.new('rock'))).to eq(1)
      end

      it 'rock compared to paper' do
        expect(Play.new('rock').<=>(Play.new('paper'))).to eq(-1)
      end
    end

    context 'plays are the same' do
      it 'paper compared to paper' do
        expect(Play.new('paper').<=>(Play.new('paper'))).to eq(0)
      end
    end
  end

  describe '.random' do
    it 'random play will return rock, paper or scissors' do
      expect(['Rock', 'Paper', 'Scissors']).to include(Play.random.play_val)
    end
  end
end

describe PlayFactory do
  describe '.get_play' do
    context 'a valid play value is provided' do
      it 'a play will be returned that matches the value provided' do
        expect(PlayFactory.get_play('Scissors').play_val).to eq('Scissors')
      end
    end

    context 'an invalid play value is provided' do
      it 'a random play will be returned that matches the value provided' do
        expect(['Rock', 'Paper', 'Scissors']).to include(PlayFactory.get_play('Computer').play_val)
      end
    end
  end
end
