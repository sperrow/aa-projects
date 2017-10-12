class Hand
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

  def initialize(cards)
    @cards = cards
  end

  def calculate
    # if straight_flush?
    #   [1, highest rank card]
    # elsif four_of_a_kind?
    #   [2, rank]
    # elsif full_house?
    #   [3, highest rank card]
    # elsif flush?
    #   [4, each rank descending]
    # elsif three_of_a_kind?
    #   [5, rank]
    # elsif two_pairs?
    #   [6, highest rank pair]
    # elsif one_pair?
    #   [7, rank]
    # else
    #   highest_rank(@cards)
    # end
  end

  def straight_flush?
    suit = card.suit
    return false if @cards.any? { |card| card.suit != suit }

  end

  def four_of_a_kind?

  end

  def full_house?

  end

  def flush?

  end

  def three_of_a_kind?

  end

  def two_pairs?

  end

  def one_pair?

  end

  def highest_rank(cards)

  end
end
