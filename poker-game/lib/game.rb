require_relative 'deck'

class PokerGame
  attr_reader :deck, :players, :pot

  def initialize(num_players)
    @deck = Deck.new
    @deck.shuffle
    @players = Array.new(num_players) { Player.new }
    @pot = 0
  end

  def deal_hands
    @players.each do |player|
      player.hand = @deck.deal
    end
  end

  def evaluate_winner
    # Winner logic for hands to be implemented
  end

  def bet(amount)
    @pot += amount
  end

  def payout(winner)
    # Payout logic here
  end
end
