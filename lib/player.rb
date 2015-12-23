class Player
  attr_accessor :name, :remaining_pieces, :board, :color

  def initialize(name = "HAL", color, board)
    @name = name
    @remaining_pieces = 12
    @board = board
    @color = color
  end

  def turn
    puts "#{@name}(#{@color}), it's your turn!"
    piece = select_piece
    @board.display_board(piece.valid_move_list)
    move_destination = get_move(piece.valid_move_list)
    piece.move_piece(move_destination, @board)
    @board.display_board
  end

  def get_move(valid_moves)
    move = ""
    until valid_moves.include?(move)
      print "\nEnter your a destination for the piece: "
      move = gets.chomp.split("").map { |x| x = x.to_i}
    end

    move
  end

  # Chooses a piece to move. Must be friendly and have valid moves.
  def select_piece
    piece = nil
    until piece and piece.is_a?(Piece) and piece.is_friendly?(self) and piece.valid_moves(@board)
      print "\nSelect a piece to move: "
      location = gets.chomp
      if (location =~ /^[1-9][1-9]$/) == 0
        piece = find_piece(location)
      end
    end

    piece
  end

  def find_piece(location)
    @board.find_square(location).piece
  end

end