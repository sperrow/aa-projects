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
        self[[x, y]] = Pawn.new(self, "white")
      end
    end

    (2...6).each do |x|
      (0...@grid.length).each do |y|
        self[[x, y]] = @empty_space
      end
    end

    (6...@grid.length).each do |x|
      (0...@grid.length).each do |y|
        self[[x, y]] = Pawn.new(self, "black")
      end
    end

    y_positions = {
      "queens" => [3],
      "bishops" => [2, 5],
      "rooks" => [0, 7],
      "knights" => [1, 6],
      "kings" => [4]
    }

    y_positions.each do |piece, arr|
      arr.each do |y|
        case piece
        when "queens"
          self[[0, y]] = Queen.new(self, "white")
          self[[7, y]] = Queen.new(self, "black")
        when "bishops"
          self[[0, y]] = Bishop.new(self, "white")
          self[[7, y]] = Bishop.new(self, "black")
        when "rooks"
          self[[0, y]] = Rook.new(self, "white")
          self[[7, y]] = Rook.new(self, "black")
        when "knights"
          self[[0, y]] = Knight.new(self, "white")
          self[[7, y]] = Knight.new(self, "black")
        when "kings"
          self[[0, y]] = King.new(self, "white")
          self[[7, y]] = King.new(self, "black")
        end
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

    if start_piece.is_valid_move?(start_pos, end_pos)
      self[end_pos] = start_piece
      self[start_pos] = @empty_space
      true
    else
      puts "Invalid move"
      false
    end
  end

  def in_bounds(pos)
    pos.all? { |coord| coord.between?(0, 7) }
  end

  def checkmate?(color)
    false
  end
end
