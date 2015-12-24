class Piece
  attr_accessor :player, :location, :alive, :king, :valid_move_list, :board

  def initialize(player, loc, board)
    @player = player
    @location = loc
    @board = board
    @alive = true
    @king = false
  end

  def is_friendly?(player)
    if @player == player
      true
    else
      puts "That piece doesn't belong to you.\n\n"
      false
    end
  end

  # Returns an array of valid coordinates the piece can move to.
  def valid_moves
    @valid_move_list = []
    forward = @player.color == "w" ? 1 : -1
      
    possible_moves = [[@location[0] - 1, @location[1] + forward],
                      [@location[0] + 1, @location[1] + forward]]
    if @king
      possible_moves << [@location[0] - 1, @location[1] - forward]
      possible_moves << [@location[0] + 1, @location[1] - forward]
    end
    
    possible_moves.each do |target|
      square = board.find_square(target)
      next unless square
      if !square.piece
        @valid_move_list << square.location
      elsif square.piece.player != @player
       
        i = [target[0] - @location[0], target[1] - @location[1]]
        jump_enemy_cords = [target[0] + i[0], target[1] + i[1]]
        jump_enemy_square = board.find_square(jump_enemy_cords)

        unless !jump_enemy_square or jump_enemy_square.piece
          @valid_move_list << jump_enemy_square.location
        end
      end
    end
    puts "That piece has no valid moves.\n\n" if @valid_move_list.count == 0
    @valid_move_list.count == 0 ? false : @valid_move_list
  end

  def move_piece(destination)
    start_square = board.find_square(@location)
    end_square = board.find_square(destination)
    start_square.piece, end_square.piece = end_square.piece, start_square.piece
    end_square.piece.location = end_square.location

    if (end_square.location[0] - start_square.location[0]).abs == 2
      capture_piece(start_square.location, end_square.location)
    end

    if (@location[1] == 1 && @player.color == "b") or (@location[1] == 8 && @player.color == "w")
      @king = true
    end
  end

  def capture_piece(start_square, end_square)
    x = (start_square[0] + end_square[0])/2
    y = (start_square[1] + end_square[1])/2

    enemy_square = board.find_square([x, y])
    enemy = enemy_square.piece

    enemy_square.piece = nil
    enemy.location = nil
    enemy.player.remaining_pieces -= 1
  end

  def update_board
    board.find_square(location.join("")).piece = self
  end


  def remove_piece
    board.find_square(location).piece = nil
    @alive = false
    @player.remaining_pieces -= 1
    @location = nil
  end

end