require_relative 'player'

RSpec.describe Player do
  describe "#initialize" do
    context "with default name" do
      it "creates a player with the default name 'Player'" do
        player = Player.new
        expect(player.name).to eq("Player")
      end
    end

    context "with custom name" do
      it "creates a player with the specified name" do
        player = Player.new("Alice")
        expect(player.name).to eq("Alice")
      end
    end

    it "initializes player with an empty hand" do
      player = Player.new
      expect(player.hand).to be_empty
    end

    it "initializes player with 100 chips" do
      player = Player.new
      expect(player.chips).to eq(100)
    end
  end

  describe "attributes" do
    let(:player) { Player.new }

    it "allows reading and writing of name attribute" do
      player.name = "Bob"
      expect(player.name).to eq("Bob")
    end

    it "allows reading and writing of hand attribute" do
      player.hand = ["2 of Hearts", "3 of Diamonds"]
      expect(player.hand).to eq(["2 of Hearts", "3 of Diamonds"])
    end

    it "allows reading and writing of chips attribute" do
      player.chips = 150
      expect(player.chips).to eq(150)
    end
  end
end
