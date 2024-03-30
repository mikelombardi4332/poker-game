require_relative '../lib/game'

RSpec.describe PokerGame do
  let(:game) { PokerGame.new(4) }

  describe "#initialize" do
    it "initializes the game with the correct number of players" do
      expect(game.players.length).to eq(4)
    end

    it "initializes the deck and shuffles it" do
      expect(game.deck.cards.length).to eq(52)
      expect(game.deck.cards).not_to eq(game.deck.cards.sort)
    end

    it "initializes the pot to 0" do
      expect(game.pot).to eq(0)
    end
  end

  describe "#deal_hands" do
    it "deals 5 cards to each player" do
      game.deal_hands
      game.players.each do |player|
        expect(player.hand.length).to eq(5)
      end
    end

    it "removes dealt cards from the deck" do
      initial_deck_size = game.deck.cards.length
      game.deal_hands
      expect(game.deck.cards.length).to eq(initial_deck_size - 4 * 5)
    end
  end

  describe "#evaluate_winner" do
    it "correctly identifies the player with the best hand" do
      player1 = double("Player", hand: ["Ace of Hearts", "King of Hearts", "Queen of Hearts", "Jack of Hearts", "10 of Hearts"])
      player2 = double("Player", hand: ["King of Spades", "King of Diamonds", "King of Clubs", "King of Hearts", "9 of Hearts"])
      allow(game).to receive(:players).and_return([player1, player2])
      winner = game.evaluate_winner
      expect(winner).to eq(player1)
    end
  end

  describe "#evaluate_hand_rank" do
    it "correctly evaluates the hand rank for different types of hands" do
      hand1 = ["10 of Hearts", "Jack of Hearts", "Queen of Hearts", "King of Hearts", "Ace of Hearts"]
      hand2 = ["2 of Hearts", "3 of Diamonds", "4 of Clubs", "5 of Spades", "6 of Hearts"]
      hand3 = ["King of Spades", "King of Diamonds", "King of Clubs", "King of Hearts", "9 of Hearts"]
      game.evaluate_hand_rank(hand1) == 8 # Straight Flush
      game.evaluate_hand_rank(hand2) == 4 # Straight
      game.evaluate_hand_rank(hand3) == 7 # Four of a Kind
    end
  end

  describe "#bet" do
    it "subtracts the bet amount from the player's chips and adds it to the pot" do
      player = double("Player", chips: 100)
      game.bet(player, 20)
      expect(player.chips).to eq(80)
      expect(game.pot).to eq(20)
    end
  end

  describe "#payout" do
    it "adds the pot amount to the winning player's chips and resets the pot to 0" do
      winner = double("Player", chips: 0)
      game.pot = 100
      game.payout(winner)
      expect(winner.chips).to eq(100)
      expect(game.pot).to eq(0)
    end
  end

  describe "#draw" do
    it "allows the player to discard and draw new cards" do
      player = double("Player", hand: ["2 of Hearts", "3 of Diamonds", "4 of Clubs", "5 of Spades", "6 of Hearts"])
      allow(game.deck).to receive(:deal).and_return(["Ace of Spades", "Ace of Diamonds"])
      discarded_cards = game.draw(player, [0, 1])
      expect(discarded_cards).to eq(["2 of Hearts", "3 of Diamonds"])
      expect(player.hand).to eq(["4 of Clubs", "5 of Spades", "6 of Hearts", "Ace of Spades", "Ace of Diamonds"])
    end
  end
end

RSpec.describe Deck do
  let(:deck) { Deck.new }

  describe "#initialize" do
    it "initializes a deck with 52 cards" do
      expect(deck.cards.length).to eq(52)
    end
  end

  describe "#shuffle" do
    it "shuffles the deck" do
      initial_order = deck.cards.dup
      deck.shuffle
      expect(deck.cards).not_to eq(initial_order)
    end
  end

  describe "#deal" do
    it "deals the specified number of cards from the deck" do
      cards = deck.deal(5)
      expect(cards.length).to eq(5)
      expect(deck.cards.length).to eq(52 - 5)
    end
  end
end

RSpec.describe Player do
  let(:player) { Player.new("Player 1") }

  describe "#initialize" do
    it "initializes the player with a name and an empty hand" do
      expect(player.name).to eq("Player 1")
      expect(player.hand).to be_empty
