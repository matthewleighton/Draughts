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
    forward = @player.color == "W" ? 1 : -1
      
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
      p end_square.location
      p start_square.location
      x = (end_square.location[0] + start_square.location[0])/2
      y = (end_square.location[1] + start_square.location[1])/2
      
      enemy_square = board.find_square([x, y])
      enemy = enemy_square.piece

      enemy.player.remaining_pieces -= 1
      enemy.location = nil
      enemy_square.piece = nil
    end
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