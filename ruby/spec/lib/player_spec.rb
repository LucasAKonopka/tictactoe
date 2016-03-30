require 'rspec'
require './lib/player'

describe Player do
  it "initializes a new player" do
    expect(Player.new).not_to be(nil)
  end
  
  it "has attribute player with default type 'human'" do
    p = Player.new
    expect(p.type).to eq('human')
  end
  
  
  it "has attribute symbol that defaults to 'x'" do
    p = Player.new
    expect(p.sym).to eq('x')
  end
  
  context "#valid_sym?" do
    p = Player.new
    it "recognizes a valid symbol" do
      p.sym = "Q"
      expect(p.valid_sym?).to eq(true)
    end
  end
  
  context "#player_name" do
    p = Player.new("AI")
    it "sets an AI's default name" do
      p.player_name
      expect(p.name).to eq("AI x")
    end
  end
  
  
  
  
  
end