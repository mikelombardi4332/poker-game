require 'rspec'
require_relative '../deck'

RSpec.describe Deck do
  describe ".count" do
    it "correctly displays 52 cards" do
      deck = Deck.new
      expect(deck.count).to eq(52)
    end
  end
end
