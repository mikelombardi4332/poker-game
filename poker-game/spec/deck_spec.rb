require_relative 'deck'

RSpec.describe Deck do
  describe "#initialize" do
    it "initializes a new deck with 52 cards" do
      deck = Deck.new
      expect(deck.cards.length).to eq(52)
    end
  end

  describe "#shuffle" do
    it "shuffles the deck" do
      deck = Deck.new
      original_deck = deck.cards.dup

      deck.shuffle

      expect(deck.cards).not_to eq(original_deck)
    end
  end

  describe "#deal" do
    it "deals a hand of 5 cards" do
      deck = Deck.new
      hand = deck.deal
      expect(hand.length).to eq(5)
    end

    it "removes cards from the deck when dealing" do
      deck = Deck.new
      initial_count = deck.cards.length
      deck.deal
      expect(deck.cards.length).to eq(initial_count - 5)
    end
  end
end
