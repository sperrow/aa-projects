class Piece
  attr_reader :color, :symbol
  def initialize(board, color)
    @board = board
    @color = color
    @symbol = "?"
  end

  def to_s
    @color == "white" ? @symbol.white : @symbol.black
  end
end

class NullPiece < Piece
  def initialize
    @color = "gray"
    @symbol = " "
  end
end

class SlidingPiece < Piece

end

class Queen < SlidingPiece
  def initialize
    super
    @symbol = "Q"
  end

  def is_valid_move?(start_pos, end_position)

  end
end
