require './lib/board.rb'
require './lib/player.rb'
require './lib/console.rb'

class Game
  
  def turn_flow(board, console, first_player, second_player) #method for regulating the game flow
    console.draw_board(board.position)
    until board.game_over?(board.position)
      
      #if first player is AI ai_move else human moves
      if first_player.type == 'AI'
        board.turn = first_player.sym
        console.ai_turn
        board.make_best_move(board, first_player.sym)
        console.draw_board(board.position)
        console.ai_move(first_player.sym,board.best_move)
        
      else
        board.turn = first_player.sym
        board.human_move(first_player.sym)
        console.draw_board(board.position)
      end
      break if board.game_over?(board.position)
      
      
      #if Second Player is AI ai_move else human moves
      if second_player.type == 'AI'
        board.turn = second_player.sym
        console.ai_turn
        board.make_best_move(board, second_player.sym)
        console.draw_board(board.position)
        console.ai_move(second_player.sym, board.best_move)
        
      else
        board.turn = second_player.sym
        board.human_move(second_player.sym)
        console.draw_board(board.position)
      end
      break if board.game_over?(board.position)
      
    end
  end
  
  def play
    b = Board.new
    p1 = Player.new
    p2 = Player.new
    
    c = Console.new
    c.welcome
    
    game_type=c.select_game
    
    #Setup the board for the game type
    if game_type==1
      puts "Player 1: "
      sym1 = c.select_symbol
      p1.sym = sym1
      b.player = sym1
      puts "Player 2: "
      sym2 = c.select_symbol
      p2.sym = sym2
      b.opponent = sym2
    elsif game_type==2
      puts "Player 1: "
      sym1 = c.select_symbol
      p1.sym = sym1
      b.player = sym1
      puts "Choose for AI : "
      sym2 = c.select_symbol
      p2.sym = sym2
      p2.type = 'AI'
      b.opponent=sym2
      
    else
      puts "FOR AI 1: "
      sym1 = c.select_symbol
      puts "FOR AI 2: "
      sym2 = c.select_symbol
      p1.type = 'AI'
      p2.type = 'AI'
      p1.sym = sym1
      p2.sym = sym2
      b.player = sym1
      b.opponent=sym2
    end
    
    #Choose who goes first
    first = c.whos_first(p1.sym, p2.sym)
    
    #Play the game
    if first == 1
      b.turn = p1.sym
      turn_flow(b,c,p1,p2)
    else
       b.turn = p2.sym
       turn_flow(b,c,p2,p1)
    end
    
    #Declare a victor!!!
    if b.win?(b.player, b.position)
      c.victory(b.player)
    elsif b.win?(b.opponent,b.position)
      c.victory(b.opponent)
    else
      puts "DRAW!".red
    end
  end
end

game = Game.new
game.play
