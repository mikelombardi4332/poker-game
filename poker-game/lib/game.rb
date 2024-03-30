class Player
  attr_accessor :name, :hand

  def initialize(name)
    @name = name
    @hand = []
  end

  def receive(cards)
    @hand += cards
  end

  def discard(indexes)
    indexes.sort.reverse_each { |i| @hand.delete_at(i) }
  end
end

class Deck
  attr_reader :cards

  SUITS = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
  RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', 'King', 'Ace']

  def initialize
    @cards = []
    new_deck
  end

  def new_deck
    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards << "#{rank} of #{suit}"
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal(num_cards)
    @cards.shift(num_cards)
  end
end

class PokerGame
  attr_reader :deck, :players, :pot

  def initialize(num_players)
    @deck = Deck.new
    @deck.shuffle
    @players = Array.new(num_players) { |i| Player.new("Player #{i + 1}") }
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
      hand_rank = evaluate_hand_rank(current_hand)

      if best_hand.nil? || hand_rank > best_hand
        best_hand = hand_rank
        winning_player = player
      end
    end

    winning_player
  end

  def evaluate_hand_rank(hand)
    # Count occurrences of ranks and suits
    ranks_count = Hash.new(0)
    suits_count = Hash.new(0)

    hand.each do |card|
      rank, suit = card.split(' of ')
      ranks_count[rank] += 1
      suits_count[suit] += 1
    end

    # Check for different hand ranks
    if has_straight?(ranks_count) && has_flush?(suits_count)
      return 8 # Straight Flush
    elsif has_n_of_a_kind?(ranks_count, 4)
      return 7 # Four of a Kind
    elsif has_n_of_a_kind?(ranks_count, 3) && has_n_of_a_kind?(ranks_count, 2)
      return 6 # Full House
    elsif has_flush?(suits_count)
      return 5 # Flush
    elsif has_straight?(ranks_count)
      return 4 # Straight
    elsif has_n_of_a_kind?(ranks_count, 3)
      return 3 # Three of a Kind
    elsif count_pairs(ranks_count) == 2
      return 2 # Two Pair
    elsif count_pairs(ranks_count) == 1
      return 1 # One Pair
    else
      return 0 # High Card
    end
  end

  def has_straight?(ranks_count)
    sorted_ranks = ranks_count.keys.sort_by { |rank| Deck::RANKS.index(rank) }
    sorted_ranks.each_cons(5) do |hand_ranks|
      return true if (Deck::RANKS.index(hand_ranks.last) - Deck::RANKS.index(hand_ranks.first)) == 4
    end
    false
  end

  def has_flush?(suits_count)
    suits_count.any? { |_, count| count == 5 }
  end

  def has_n_of_a_kind?(ranks_count, n)
    ranks_count.any? { |_, count| count == n }
  end

  def count_pairs(ranks_count)
    ranks_count.values.count { |count| count == 2 }
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

# Test scenario
game = PokerGame.new(4)

# Deal hands
puts "Dealing hands..."
game.deal_hands

# Display players' hands
puts "Players' hands:"
game.players.each do |player|
  puts "#{player.name}: #{player.hand.join(', ')}"
end

# Evaluate winner
puts "Evaluating winner..."
winner = game.evaluate_winner
puts "The winner is: #{winner.name} with a #{winner.hand.join(', ')}"
