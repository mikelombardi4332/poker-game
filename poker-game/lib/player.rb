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
