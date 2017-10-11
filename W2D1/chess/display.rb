require "colorize"
require_relative "cursor"

class Display
  attr_reader :cursor

  def initialize(board)
    @board = board
    @cursor = Cursor.new([5, 2], board)
  end

  def render
    cursor_pos = @cursor.cursor_pos
    # p String.colors
    puts "-----".on_light_black * 8
    (0..7).each do |i|
      (0..7).each do |j|
        piece = @board[[i, j]].to_s
        if cursor_pos == [i, j]
          print "|".on_light_black + " #{piece} ".on_red + "|".on_light_black
        else
          print "| #{piece} |".on_light_black
        end
      end
      print "\n"
      puts "-----".on_light_black * 8
    end
  end
end
