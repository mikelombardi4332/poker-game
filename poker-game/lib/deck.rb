class Deck
    attr_reader :cards
    suits = ['Hearts', 'Diamonds', 'Clubs', 'Spades']
    rank = ['2','3','4','5','6','7','8','9','10','Jack','Queen','King','Ace']

    def initialize
        @cards = []
        new_deck
    end


    def new_deck
        suits.each do |suits|
            rank.each do |rank|
                @cards << "#{rank} of #{suit}"
            end
        end
    end

    def shuffle
        @cards.shuffle!
    end

    def deal
        hand = @cards.shift(5)
        hand
    end

end


