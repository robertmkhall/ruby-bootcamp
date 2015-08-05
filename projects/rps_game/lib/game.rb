class Game
  def output_winner(play1_val, play2_val)
    play1 = PlayFactory.get_play(play1_val)
    play2 = PlayFactory.get_play(play2_val)

    case play1 <=> play2
    when 1
      "Player 1 wins: #{play1.play_val} beats #{play2.play_val}"
    when -1
      "Player 2 wins: #{play2.play_val} beats #{play1.play_val}"
    else
      "It's a draw: #{play1.play_val} = #{play2.play_val}"
    end
  end

  def first_play
    puts 'Enter play for player 1 (Rock, Paper or Scissors)'
    gets.chomp
  end

  def second_play
    puts 'Enter play for player 2 (Rock, Paper or Scissors - or Computer if you wish to play against the Computer)'
    gets.chomp
  end

  def play_game
    play1 = first_play
    play2 = second_play
    puts output_winner(play1, play2)
  end
end
