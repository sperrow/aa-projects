require "card"
require "deck"
require "hand"
require "player"
require "game"
require "rspec"

describe Card do
  subject(:card) { Card.new("heart", "4") }

  describe "#initialize" do
    it "assigns suit and rank" do
      expect(card.suit).to eq("heart")
      expect(card.rank).to eq("4")
    end
  end
end

describe Deck do
  subject(:sample_deck) { Deck.new }

  describe "#initialize" do
    it "creates 52 unique cards" do
      deck = sample_deck.cards
      expect(deck.uniq.count).to eq(52)
    end
  end

  describe "#pop" do
    it "removes last card from deck" do
      deck = sample_deck.cards
      length = deck.length
      deck.pop
      expect(deck.length).to eq(length - 1)
    end
  end
end

describe Hand do
  let(:cards) do
    [
      { "suit" => "heart", "rank" => "4" },
      { "suit" => "heart", "rank" => "3" },
      { "suit" => "club", "rank" => "J" },
      { "suit" => "spade", "rank" => "7" },
      { "suit" => "diamond", "rank" => "4" }
    ]
  end
  subject(:hand) { Hand.new(cards) }

  describe "#initialize" do
    it "assigns an array of cards" do
      expect(hand.cards.length).to eq(5)
    end
  end

end

describe Player do
  subject(:player) { Player.new("Bob") }

  describe "#initialize" do
    it "should have a starting pot of $500" do
      expect(player.pot).to eq(500)
    end
  end

  describe "#deal" do
    it "should take in a hand of five cards" do
      hand = Array.new(5) { "card" }
      player.deal(hand)
      expect(player.hand.length).to eq(5)
    end
  end
end
