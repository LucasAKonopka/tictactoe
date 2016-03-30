require 'colorize'
class Console
  
  def welcome
    puts "WELCOME TO TIC TAC TOE".green
  end
  


  def draw_board(positions)
    puts "
        Board Positions:
           1 | 2 | 3
          ------------
           4 | 5 | 6
          ------------
           7 | 8 | 9 ".red
    puts "
         Game Positions:
           #{positions[0]} | #{positions[1]} | #{positions[2]} 
          ------------
           #{positions[3]} | #{positions[4]} | #{positions[5]}
          ------------
           #{positions[6]} | #{positions[7]} | #{positions[8]} ".green
  end
  
  def move(player_name)
    
    print "#{player_name} choose your move: \n"
  end
  
  def select_game
    puts %q(Please select your game type:).green
    puts %q(
            1: human vs human
            2: human vs AI
            3: AI vs AI).yellow
    game_type = gets.chomp.to_i
    unless (game_type == 1) ||(game_type == 2) || (game_type == 3)
      puts "Invalid input please enter: 1, 2 or 3"
      select_game
    end
    game_type
  end
  
  def ai_move(sym, position)
    puts "AI #{sym.upcase} placed an #{sym} at position #{position+1}"
  end
  
  def select_symbol
    puts "Please select the symbol you would like to mark the board with:".green
    sym = gets.chomp
    if sym.length != 1
      puts "Invalid symbol! Symbol must be one character. 
      Please enter only one character".red
      sym = select_symbol
    end
    sym
  end
  
  
  def whos_first(p1,p2)
    puts "Who wants to go first? (1)'#{p1}'' or (2)'#{p2}'' ?"
    order = gets.chomp.to_i
    unless ( order == 1) || (order == 2 )
      puts "Invalid input! Please enter 1 or 2".red
      whos_first(p1,p2)
    end
    order
  end
  
  
  def ai_turn
    puts"AI thinking..."
    sleep(0.5)
  end
  
  def victory(player)
    puts "Player #{player.upcase} is the WINNER!!".green
  end
end
