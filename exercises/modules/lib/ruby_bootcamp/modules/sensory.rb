module Talker

  DEFAULT_GREETINGS = ['hello', 'good day', "what's up", 'yo', 'hi', 'sup', 'hey']
  DEFAULT_GOODBYES = ['goodbye', 'see you later', 'in a while crocodile', 'l8rs', 'bye for now']

  def say (message)
    puts message.downcase
  end

  def shout(message)
    puts "#{message.upcase}!!!"
  end

  def greeting
    @greetings ||= DEFAULT_GREETINGS
    @greetings.sample
  end

  def farewell
    @goodbyes ||= DEFAULT_GOODBYES
    @goodbyes.sample
  end
end

module Mover
  attr_reader :position

  def move(direction)
    @position ||= {logitude: 0, lattitude: 0 }

    plane,amount = nil, nil
    if  %i{left right}.include?(direction)
      plane, amount = :lattitude, (direction == :left ? 1 : -1)
    elsif %i{forwards backwards}.include?(direction)
      plane, amount = :logitude, (direction == :forwards ? 1 : -1)
    else
      raise InvalidDirectionException, "I just don't move like that"
    end

    position[plane]+= amount
    self
  end

  def move_left
    move :left
  end

  def move_right
    move :right
  end

  def move_forwards
    move :forwards
  end

  def move_backwards
    move :backwards
  end

  class InvalidDirectionException < RuntimeError
  end
end