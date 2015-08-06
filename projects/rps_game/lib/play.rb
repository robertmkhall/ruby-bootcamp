class Play
  include Comparable

  attr_reader :play_val

  @winner_rules = {
    'Rock' => 'Scissors',
    'Paper' => 'Rock',
    'Scissors' => 'Paper'
  }

  def self.winner_rules
    @winner_rules
  end

  def self.random
    Play.new(Play.winner_rules.keys.sample)
  end

  def initialize(play_val)
    @play_val = play_val.capitalize
  end

  def <=>(other)
    if @play_val == other.play_val
      0
    else
      Play.winner_rules[@play_val] == other.play_val ? 1 : -1
    end
  end
end

class PlayFactory

  def self.get_play(play_value)
    Play.winner_rules.key?(play_value.capitalize) ? Play.new(play_value.capitalize) : Play.random
  end
end
