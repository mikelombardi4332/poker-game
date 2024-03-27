class Player
    attr_accessor :name, :hand, :chips
  
    def initialize(name = "Player")
      @name = name
      @hand = [] #implement hand from deck
      @chips = 100 # Starting chips
    end
  end
  