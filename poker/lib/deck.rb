require "card"

class Deck
  attr_reader :cards

  SUITS = %w{club spade heart diamond}.freeze
  RANKS = {
    "A" => 1,
    "2" => 2,
    "3" => 3,
    "4" => 4,
    "5" => 5,
    "6" => 6,
    "7" => 7,
    "8" => 8,
    "9" => 9,
    "10" => 10,
    "J" => 11,
    "Q" => 12,
    "K" => 13
  }.freeze

  def initialize
    @cards = []
    populate
  end

  def pop
    @cards.pop
  end

  private

  def populate
    SUITS.each do |suit|
      RANKS.each_key do |rank|
        @cards << Card.new(suit, rank)
      end
    end
    @cards.shuffle!
  end
end
