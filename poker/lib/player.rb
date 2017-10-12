class Player
  attr_reader :name, :pot, :hand

  def initialize(name)
    @name = name
    @pot = 500
  end

  def deal(hand)
    @hand = hand
  end
end
