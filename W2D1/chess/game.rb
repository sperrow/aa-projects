require_relative "board"
require_relative "display"

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
  end

  def play
    @display.render
    take_turn
  end

  def take_turn
    pos = nil
    until pos
      puts "Select starting position"
      @display.render
      pos = @display.cursor.get_input
    end
    p pos
  end


end


if __FILE__ == $PROGRAM_NAME
  a = Game.new

  a.play
end
