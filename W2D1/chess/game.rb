require_relative "board"
require_relative "display"

class Game

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @player1 = "white"
    @player2 = "black"
    @current_player = @player1
  end

  def play
    until @board.checkmate?(@player1) || @board.checkmate?(@player2)
      take_turn
    end
  end

  def take_turn
    start_pos = get_start_pos
    end_pos = get_end_pos(start_pos)
    puts "Start: #{start_pos}, End: #{end_pos}"

    return take_turn unless @board.move_piece(start_pos, end_pos)
    @display.render
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def get_start_pos
    start_pos = nil
    until start_pos
      puts "Player #{@current_player}: Select starting piece"
      @display.render
      start_pos = @display.cursor.get_input
    end

    piece = @board[start_pos]
    if !piece.is_valid_start_piece?(@current_player)
      puts "Not a valid piece"
      return get_start_pos
    end
    start_pos
  end

  def get_end_pos(start_pos)
    end_pos = nil
    until end_pos
      puts "Start position: #{start_pos}"
      puts "Player #{@current_player}: Select destination"
      @display.render
      end_pos = @display.cursor.get_input
    end

    piece = @board[end_pos]
    if !piece.is_valid_end_piece?(@current_player)
      puts "Not a valid destination"
      return get_end_pos(start_pos)
    end
    end_pos
  end
end


if __FILE__ == $PROGRAM_NAME
  a = Game.new

  a.play
end
