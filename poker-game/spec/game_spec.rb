require_relative 'poker_game'

RSpec.describe PokerGame do
  describe "#initialize" do
    it "initializes a new game with the specified number of players" do
      game = PokerGame.new(4)
      expect(game.players.length).to eq(4)
    end

    it "initializes a new game with a shuffled deck" do
      game = PokerGame.new(4)
      expect(game.deck.cards).not_to eq(Deck.new.cards)
    end

    it "initializes a new game with an empty pot" do
      game = PokerGame.new(4)
      expect(game.pot).to eq(0)
    end
  end

  describe "#deal_hands" do
    it "deals hands to all players" do
      game = PokerGame.new(4)
      game.deal_hands
      expect(game.players.all? { |player| player.hand.length == 5 }).to be_truthy
    end
  end

end
