class Board
  attr_accessor :position, :turn, :best_move, :player, :opponent, :scores, :moves
  @depth = 0
  def initialize(position=nil, turn='x', player=nil, opponent=nil)
    @position = position || %w(-)*9
    @turn = turn 
    @player = player ||= 'x'
    @opponent = opponent ||= 'o'
    @scores = []
    @moves = []
    @best_move = 0
    
  end
  
  def human_move(player)
    puts "Player #{player}'s turn enter a spot (1-9)"
    idx = gets.chomp.to_i-1
    if @position[idx] == '-'
      @position[idx] = turn
    else
      puts "That spot is taken. Please enter a new spot"
      human_move(player)
    end
    @position
  end
  
  def move(idx)
    new_game_state = Board.new(@position.dup, @turn, @player, @opponent)
    new_game_state.position[idx] = turn
    new_game_state.turn = new_game_state.switch_turns
    new_game_state
    
  end
  
  def switch_turns
    if turn == player
      turn = opponent
    else
      turn = player
    end
  end
  
  
  def possible_moves(position)
    available = position.each_with_index.map { |p,i| i if p == "-" }
    available.compact
  end
  
  def win?(sym, position)
    rows = position.each_slice(3).to_a  
    rows.any? { |r| r.all? { |s| s == sym } } ||
    rows.transpose.any? { |c| c.all? { |s| s ==sym } } ||
    rows.each_with_index.all? { |row,i| row[i]==sym } || 
    rows.each_with_index.all? { |row,i| row[2-i]==sym }
  end
  
  
  
  def minimax(board, depth=0)
    return 10 - depth if win?(board.player, board.position)
    return depth - 10 if win?(board.opponent, board.position)
    return 0 if possible_moves(board.position).empty?
    moves = []
    scores = []
    possible_moves(board.position).each do |m|
      future_board = board.move(m)
      future_board.turn = board.switch_turns
      moves << m
      scores << minimax(future_board,depth+1)
    end
    
    
    
    if board.turn == player
      max_score_index = scores.each_with_index.max[1]
      @best_move = moves[max_score_index] if scores[max_score_index] > @best_move
      return scores.max
    else
      min_score_index = scores.each_with_index.min[1]
      @best_move = moves[min_score_index] if scores[min_score_index] < @best_move
      return scores.min
    end
  end
  
  def make_best_move(board, player)
    if possible_moves(board.position).size == 1
      position[possible_moves(board.position)[0]] = player
    else
      minimax(board)
      position[best_move] = player
      position
    end
  end
  
  def game_over?(position)
    return true if win?(player,position) || win?(opponent,position) || possible_moves(position).empty?
  end
  
  def first_second_move
    if position[0] == '-'
      position[0] = turn
    elsif position[4] == '-'
      position[4] = turn
    else
      position[9] = turn
    end
  end
  
end