require_relative "piece"

class Board
  def initialize
    @grid = Array.new(8) { Array.new(8) }
    @empty_space = NullPiece.new
    populate_board
  end

  def populate_board
    (0...2).each do |x|
      (0...@grid.length).each do |y|
        self[[x, y]] = Piece.new(self, "white")
      end
    end

    (2...6).each do |x|
      (0...@grid.length).each do |y|
        self[[x, y]] = @empty_space
      end
    end

    (6...@grid.length).each do |x|
      (0...@grid.length).each do |y|
        self[[x, y]] = Piece.new(self, "black")
      end
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def move_piece(start_pos, end_pos)
    start_piece = self[start_pos]
    if !start_piece || start_piece == @empty_space
      raise "No piece at that space"
    end

    if start_piece.is_valid_move?(end_pos)
      self[end_pos] = start_piece
      self[start_pos] = @empty_space
    else
      raise "Cannot move to that space"
    end
  end

  def in_bounds(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end
end
