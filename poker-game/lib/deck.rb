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
  