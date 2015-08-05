require_relative '../lib/game'
require_relative '../lib/play'
require 'mocha/test_unit'

describe Game do
  subject(:game) { described_class.new }
  let(:play_1_request_message) { "Enter play for player 1 (Rock, Paper or Scissors)\n" }
  let(:play_2_request_message) { "Enter play for player 2 (Rock, Paper or Scissors - or Computer if you wish to play against the Computer)\n"}

  describe '#output_winner' do
    context 'when the plays are different' do
      it 'Paper beats Rock when rock second play' do
        expect(subject.output_winner('paper', 'rock')).to eq('Player 1 wins: Paper beats Rock')
      end

      it 'Paper beats Rock when rock first play' do
        expect(subject.output_winner('rock', 'paper')).to eq('Player 2 wins: Paper beats Rock')
      end
    end

    context 'when the plays are the same' do
      it 'its a draw when paper plays paper' do
        expect(subject.output_winner('paper', 'paper')).to eq('It\'s a draw: Paper = Paper')
      end
    end
  end

  describe '#get_first_play' do
    before do
      allow(subject).to receive(:gets).and_return('Rock')
    end

    it 'asks user for input' do
      expect{ subject.first_play }.to output(play_1_request_message).to_stdout
    end

    it 'reads user input' do
      allow(subject).to receive(:puts)
      expect(subject.first_play).to eq('Rock')
    end
  end

  describe '#second_play' do
    it 'asks user for input' do
      expect{ subject.second_play }.to output(play_2_request_message).to_stdout
    end

    context 'playing against a human component' do
      before do
        allow(subject).to receive(:gets).and_return('Rock')
      end

      it 'reads user input' do
        allow(subject).to receive(:puts)
        expect(subject.second_play).to eq('Rock')
      end
    end

    context 'playing against the computer' do
      before do
        allow(subject).to receive(:gets).and_return('Computer')
      end

      it 'reads user input' do
        allow(subject).to receive(:puts)
        expect(subject.second_play).to eq('Computer')
      end
    end
  end

  describe '#play_game' do
    context 'two human players compete' do
      before do
        allow(subject).to receive(:gets).and_return('Rock', 'Paper')
      end

      it 'the correct winner will be displayed after both plays entered' do
        expected_output = play_1_request_message + play_2_request_message + "Player 2 wins: Paper beats Rock\n"
        expect{subject.play_game}.to output(expected_output).to_stdout
      end
    end

    context 'a human plays the computer' do
      before do
        allow(subject).to receive(:gets).and_return('Scissors', 'Computer')
      end

      it 'the correct winner will be displayed after both plays entered' do
        PlayFactory.expects(:get_play).at_most_once.with('Scissors').returns(Play.new('scissors'))
        PlayFactory.expects(:get_play).at_most_once.with('Computer').returns(Play.new('paper'))

        expected_output = play_1_request_message + play_2_request_message + "Player 1 wins: Scissors beats Paper\n"
        expect{subject.play_game}.to output(expected_output).to_stdout
      end
    end
  end
end
