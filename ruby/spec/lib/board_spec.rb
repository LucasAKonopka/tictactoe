require 'rspec'
require './lib/board'
require 'pry'

describe Board do
  let(:b) { Board.new(nil, 'x') }
  it "initializes a new board" do
    expect(b.position).to eq(%w(-)*9)
  end
  
  it "initializes turn" do
    expect(b.turn).to eq("x")
  end
  
  context ".new(board,turn)" do
    let(:b1) { Board.new(%w(x - - - - - - - -), "o","x","o") }
    
    it "updates the board" do
      expect(b1.position).to eq(%w(x - - - - - - - -))
    end
    
    it "updates the turn" do
      expect(b1.turn).to eq("o")
    end
  end
  
  context "#move" do
    let(:b) { Board.new(nil,"x","x","o") }
    
    it "updates board when #move is called" do
      
      b1 = b.move(0)
      expect(b1.position).to eq(%w(x - - - - - - - -))
    end
    
    it "switches turns" do
      b1 = b.move(0)
      
      expect(b1.turn).to eq("o")
    end
  end
  
  context "#possible_moves" do
    let(:b) { Board.new(nil,'x', "x", "o") }
    it "returns a list of possible moves" do
      b1 = b.move(0)
      expect(b.possible_moves(b1.position)).to eq([1, 2, 3, 4, 5, 6, 7, 8])
      
      b2 = Board.new(%w(o x o x x o x o -),"x","x","o")
      expect(b2.possible_moves(b2.position)).to eq([8])
      
      b3 = Board.new(%w(o x o x x o x o x),"x","x","o")
      expect(b3.possible_moves(b3.position)).to eq([])
    end
  end
  
  context '#win?' do
    it "notices a victory" do
      b = Board.new(%w(x x x
                       - - -
                       - - -), "x" ,"x","o") 
      expect(b.win?('x',b.position)).to eq(true)
      
      b = Board.new(%w(- - -
                       - - -
                       x x x), "x","x","o") 
      expect(b.win?('x',b.position)).to eq(true)
      
      b = Board.new(%w(- - -
                       x x x
                       - - -), "x","x","o") 
    
      expect(b.win?('x',b.position)).to eq(true)
    end
    it "notices victory for diagnals" do
      b = Board.new(%w(- - o
                       - o -
                       o - -), "o","x","o") 
      expect(b.win?('o', b.position)).to eq(true)
      
      b = Board.new(%w(o - -
                       - o -
                       - - o), "o","x","o") 
      expect(b.win?('o',b.position)).to eq(true)
    end
    
    it "notices victory for columns" do  
      b = Board.new(%w(o - -
                       o - -
                       o - -), "o", "x","o") 
      expect(b.win?('o',b.position)).to eq(true)
      
      b = Board.new(%w(- o -
                       - o -
                       - o -), "o","x","o") 
      expect(b.win?('o',b.position)).to eq(true)
      
      b = Board.new(%w(- - o
                       - - o
                       - - o), "o","x","o") 
      expect(b.win?('o',b.position)).to eq(true)
    end
  end
  
  context "#minimax" do
    b = Board.new(%w(- - - x x x - - -),"x","x","o")
    b1 = Board.new(%w(- - - o o o - - -),"o","x","o")
    b2 = Board.new(%w(o x o x x o x o x),"o","x","o")
    b3 = Board.new(%w(x x - - - - - - -),"x","x","o")
    b4 = Board.new(%w(o o - - - - - - -),"o","x","o")
    b5 = Board.new(%w(o - - o - - - - -),"o","x","o")
    b6 = Board.new(%w(x x - - - - - - -),"o","x","o")
    b7 = Board.new(%w(o x x - x - - o -),"o","x","o")
    
    it "expects minimax to return 10 for win" do
      expect(b.minimax(b)).to eq(10)
    end
    it "returns -10 for loss" do
      expect(b1.minimax(b1)).to eq(-10)
    end
    it "returns 0 for a draw" do
      expect(b2.minimax(b2)).to eq(0)
    end
    
    it "compensates for game depth for'x'" do
      expect(b3.minimax(b3)).to eq(9)
    end
    
    it "compensates for game depth for 'o" do
      expect(b4.minimax(b4)).to eq(-9)
    end
    
    it "compensates for game depth for column 'o'" do
      expect(b5.minimax(b5)).to eq(-9)
    end
    
    it "stores best move position" do
      b5.minimax(b5)
      expect(b5.best_move).to eq(6)
    end
    
    it "stores the best move for a winning move" do
      b6.minimax(b6)
      
      expect(b6.best_move).to eq(2)
    end
    
    it "it stores the best move for a block" do
      b7.player = "o"
      b7.opponent = "x"
      b7.minimax(b7)
      expect(b7.best_move).to eq(6)
    end
    
    it "makes best move in another situation" do
      b8 = Board.new(%w(o x o o - - x - x),"o","x","o")
      b8.player = 'x'
      b8.opponent = 'o'
      b8.minimax(b8)
      expect(b8.best_move).to eq(7)
    end
  end
  
  context "#make_best_move" do
    it "makes the best move" do
      b = Board.new(%w(x x - - - - - - -),"o","x","o")
      b.make_best_move(b,"x")
      expect(b.position).to eq(%w(x x x - - - - - -))
    end
    
    it "blocks a winning move" do
      b = Board.new(%w(x - o - x - - - -),"o","x","o")
      b.make_best_move(b,"o")
      expect(b.position).to eq(%w(x - o - x - - - o))
    end
  end
  
  context "#first_second_move" do
    it "makes the best move on an empty board" do
      b = Board.new(%w(- - - - - - - - -),"x","x","o")
      b.first_second_move
      expect(b.position).to eq(%w(x - - - - - - - -))
    end
    
    it "make the best move in another situation" do
        b = Board.new(%w(x o - x o - - - -),"x","x","o")
        b.make_best_move(b,"x")
        expect(b.position).to eq(%w(x o - x o - x - -))
    end
    
    
    it "makes the best second move" do
      b = Board.new(%w(o - - - - - - - -),"x","x","o")
      b.first_second_move
      expect(b.position).to eq(%w(o - - - x - - - -))
    end
  end
end