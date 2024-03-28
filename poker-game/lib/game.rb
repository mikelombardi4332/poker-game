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
    best_hand = nil
    winning_player = nil

    @players.each do |player|
      current_hand = player.hand
      if best_hand.nil? || current_hand > best_hand
        best_hand = current_hand
        winning_player = player
      elsif current_hand == best_hand
        # Handle tie-breaking logic if necessary
      end
    end

    winning_player
  end

  def bet(amount)
    @pot += amount
  end

  def payout(winner)
    # Payout logic here
  end
end
