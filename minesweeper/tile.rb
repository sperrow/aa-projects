class Tile
  attr_reader :board
  def initialize(board, pos, bomb = false)
    @board = board
    @pos = pos
    @bomb = bomb
    @revealed = false
    @flagged = false
  end

  

  def inspect
    @pos
  end

  def status
    "*"
  end

  def reveal!

  end
end
