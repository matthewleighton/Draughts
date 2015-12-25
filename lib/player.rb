class Player
  attr_accessor :name, :remaining_pieces, :board, :color, :pieces

  def initialize(name = "HAL", color, board)
    @name = name
    @remaining_pieces = 12
    @board = board
    @color = color
    @pieces = []
  end

  def turn
    puts "#{@name}(#{@color}), it's your turn!"
    piece = select_piece(generate_capture_list)
    @board.display_board(piece.valid_move_list)
    move_destination = get_move(piece.valid_move_list)
    piece.move_piece(move_destination)

    @board.display_board
  end

  # Creates a list of each of your pieces which are currently able to capture.
  def generate_capture_list
    capture_list = []
    @pieces.each do |piece|
      if (piece.valid_moves(true).count > 0) and piece.alive
        capture_list << piece
      end
    end
    capture_list.count > 0 ? capture_list : false
  end

  def capture_again(piece)
    if piece.valid_moves(true).count > 0
      @board.display_board(piece.valid_move_list)
      puts "That piece can capture again."
      move_destination = get_move(piece.valid_move_list)
      piece.move_piece(move_destination)
    end
  end

  def get_move(valid_moves)
    move = ""
    until valid_moves.include?(move)
      print "\nEnter a destination for the piece: "
      move = gets.chomp.split("").map { |x| x = x.to_i}
    end
    move
  end

  # Chooses a piece to move. Must be friendly and have valid moves.
  def select_piece(capture_list)
    piece = nil
    until piece and piece.is_a?(Piece) and piece.is_friendly?(self) and piece.valid_moves
      print "\nSelect a piece to move: "
      location = gets.chomp
      if (location =~ /^[1-9][1-9]$/) == 0
        piece = find_piece(location)
        if capture_list
          unless capture_list.include?(piece)
            piece = nil
            puts "Another piece is able to capture, so must be played."
          end
        end
      end
    end

    piece
  end

  def find_piece(location)
    @board.find_square(location).piece
  end

end