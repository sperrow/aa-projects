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

  def is_valid_start_piece?(color)
    return false if self.is_a?(NullPiece)
    @color == color
  end

  def is_valid_end_piece?(color)
    @color != color
  end

  def is_opposite_color?(end_pos)
    @color != @board[end_pos].color
  end

  def is_horizontal?(start_pos, end_pos)
    if start_pos.first == end_pos.first
      #horizontal
      p "horizontal"
      return true
    end
    false
  end

  def is_vertical?(start_pos, end_pos)
    if start_pos.last == end_pos.last
      p "vertical"
      return true
    end
    false
  end

  def is_diagonal?(start_pos, end_pos)
    slope = (end_pos.last - start_pos.last).to_f /
    (end_pos.first - start_pos.first).to_f
    if slope.abs == 1
      #for diagonal movements
      p "diagonal"
      return true
    end
    false
  end

  def is_valid_move?(_start_pos, _end_pos)
    puts "No defined move set"
  end
end

class NullPiece < Piece
  def initialize
    @color = "gray"
    @symbol = " "
  end
end

class SlidingPiece < Piece
  def is_valid_horizontal_path?(start_pos, end_pos)
    x = start_pos.first
    start_y = start_pos.last
    end_y = end_pos.last
    forward = start_y < end_y
    y = forward ? start_y + 1 : start_y - 1

    while y != end_y
      return false unless @board[[x, y]].is_a?(NullPiece)
      y = forward ? y + 1 : y - 1
    end
    p "valid horizontal path"
    true
  end

  def is_valid_vertical_path?(start_pos, end_pos)
    start_x = start_pos.first
    end_x = end_pos.first
    y = start_pos.last
    down = start_x < end_x
    x = down ? start_x + 1 : start_x - 1

    while x != end_x
      return false unless @board[[x, y]].is_a?(NullPiece)
      x = down ? x + 1 : x - 1
    end

    p "valid vertical path"
    true
  end

  def is_valid_diagonal_path?(start_pos, end_pos)
    start_x = start_pos.first
    end_x = end_pos.first
    start_y = start_pos.last
    end_y = end_pos.last
    down = start_x < end_x
    forward = start_y < end_y

    x = down ? start_x + 1 : start_x - 1
    y = forward ? start_y + 1 : start_y - 1

    while x != end_x
      return false unless @board[[x, y]].is_a?(NullPiece)
      x = down ? x + 1 : x - 1
      y = forward ? y + 1 : y - 1
    end
    puts "valid diagonal path"
    true
  end
end

class Queen < SlidingPiece
  def initialize(board, color)
    super
    @symbol = "♕"
  end

  def is_valid_move?(start_pos, end_pos)
    return false unless is_opposite_color?(end_pos)

    if is_horizontal?(start_pos, end_pos)
      return is_valid_horizontal_path?(start_pos, end_pos)
    elsif is_vertical?(start_pos, end_pos)
      return is_valid_vertical_path?(start_pos, end_pos)
    elsif is_diagonal?(start_pos, end_pos)
      return is_valid_diagonal_path?(start_pos, end_pos)
    end

    false
  end
end

class Rook < SlidingPiece
  def initialize(board, color)
    super
    @symbol = "♖"
  end

  def is_valid_move?(start_pos, end_pos)
    return false unless is_opposite_color?(end_pos)

    if is_horizontal?(start_pos, end_pos)
      return is_valid_horizontal_path?(start_pos, end_pos)
    elsif is_vertical?(start_pos, end_pos)
      return is_valid_vertical_path?(start_pos, end_pos)
    end

    false
  end
end

class Bishop < SlidingPiece
  def initialize(board, color)
    super
    @symbol = "♗"
  end

  def is_valid_move?(start_pos, end_pos)
    return false unless is_opposite_color?(end_pos)

    if is_diagonal?(start_pos, end_pos)
      return is_valid_diagonal_path?(start_pos, end_pos)
    end

    false
  end
end

class SteppingPiece < Piece

end

class Knight < SteppingPiece
  def initialize(board, color)
    super
    @symbol = "♘"
  end

  def is_valid_move?(start_pos, end_pos)
    return false unless is_opposite_color?(end_pos)


  end
end

class King < SteppingPiece
  def initialize(board, color)
    super
    @symbol = "♔"
  end

  def is_valid_move?(start_pos, end_pos)
    return false unless is_opposite_color?(end_pos)

    if (start_pos.first - end_pos.first).abs > 1
      return false
    elsif (start_pos.last - end_pos.last).abs > 1
      return false
    end

    true
  end
end

class Pawn < SteppingPiece
  def initialize(board, color)
    super
    @symbol = "♙"
    @first = true
  end

  def is_valid_move?(start_pos, end_pos)
    return false unless is_opposite_color?(end_pos)

    start_x, start_y = start_pos
    end_x, end_y = end_pos

    if @color == "white"

      # Pawn can move two spaces on first move
      if @first
        # Can move two spaces vertically
        if start_y == end_y && (end_x - start_x).between?(1, 2)
          (1..end_x - start_x).each do |i|
            return false if !@board[[start_x + i, start_y]].is_a?(NullPiece)
          end

          @first = false
          return true
        end
      end

      # Can move one space diagonally
      if (end_y - start_y).abs == 1 &&
      end_x - start_x == 1 &&
      !@board[end_pos].is_a?(NullPiece)
        @first = false
        return true
      # Pawn can move forward one space
      elsif end_x - start_x == 1 &&
      start_y == end_y &&
      @board[end_pos].is_a?(NullPiece)
        return true
      end
    else
      # Pawn can move two spaces on first move
      if @first
        # Can move two spaces vertically
        if start_y == end_y && (start_x - end_x).between?(1, 2)
          (1..start_x - end_x).each do |i|
            return false if !@board[[start_x - i, start_y]].is_a?(NullPiece)
          end

          @first = false
          return true
        end
      end

      # Can move one space diagonally
      if (start_y - end_y).abs == 1 &&
      start_x - end_x == 1 &&
      !@board[end_pos].is_a?(NullPiece)
        @first = false
        return true
      # Pawn can move forward one space
      elsif start_x - end_x == 1 &&
      start_y == end_y &&
      @board[end_pos].is_a?(NullPiece)
        return true
      end
    end
    false
  end
end
