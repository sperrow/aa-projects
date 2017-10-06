require_relative "tile"

class Board
  attr_reader :grid, :size

  def initialize(size = 9)
    @grid = Array.new(size) { Array.new(size) }
    @size = size
  end

  def populate
    positions = []
    size.times do |x|
      size.times do |y|
        positions << [x, y]
      end
    end
    bombs = size * size / 10
    positions.shuffle.each_with_index do |pos, i|
      if i < bombs
        self[pos] = Tile.new(self, pos, :b)
      else
        self[pos] = Tile.new(self, pos)
      end
    end
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    grid[x][y] = value
  end

  def render
    size.times do |x|
      size.times do |y|
        print self[[x, y]].status
      end
      puts ""
    end
  end
end

board = Board.new
board.populate
board.render
