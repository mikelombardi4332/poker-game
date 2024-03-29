class Player
  attr_accessor :name, :hand, :chips

  def initialize(name = "Player")
    @name = name
    @hand = []
    @chips = 100
  end

  def display_hand
    @hand.join(", ")
  end

  def discard(indexes)
    indexes.each { |index| @hand.delete_at(index) }
  end

  def receive(cards)
    @hand.concat(cards)
  end
end
