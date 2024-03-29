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
      player.receive(@deck.deal(5))
    end
  end

  def evaluate_winner
    best_hand = nil
    winning_player = nil

    @players.each do |player|
      current_hand = player.hand
    end

    winning_player
  end

  def bet(player, amount)
    player.chips -= amount
    @pot += amount
  end

  def payout(winner)
    winner.chips += @pot
    @pot = 0
  end

  def draw(player, indexes)
    discarded_cards = player.hand.values_at(*indexes)
    player.discard(indexes)
    player.receive(@deck.deal(indexes.length))
    discarded_cards
  end
end
