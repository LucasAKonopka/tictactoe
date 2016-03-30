
class Player
  attr_accessor :type, :sym, :name
  
  def initialize(type='human', sym='x')
    @type = type
    @sym = sym
    
  end
  
  def player_name(name=nil)
    @name = "AI #{sym}" if @type == "AI"
    @name = "Player #{sym}" if @type == "human"
  end
  
  def valid_sym?
    @sym.length == 1 ? true : false
  end
  
  
end