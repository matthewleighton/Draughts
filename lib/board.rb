require_relative 'square'
require_relative 'piece'

class Board
  attr_reader :squares

  def initialize
    @squares = []
    create_board
  end

  def create_board
    list = []
    y = 1
    x = 0

    until list.count == 64
      if x == 8
        y += 1
        x = 1
      else
        x += 1
      end
      list << Array.new([x, y])
    end

    list.each do |coordinates|
      @squares << Square.new(coordinates)
    end
  end

  def place_pieces(p_one, p_two)
    row = 0
    until row == 9
      sq_list = @squares.slice(row*8, 8) # One row of squares
      sq_list.each do |sq|
        if row < 3
          if row % 2 == 0
            sq.piece = Piece.new(p_two, sq.location, self) if sq.location[0] % 2 == 0
          else
            sq.piece = Piece.new(p_two, sq.location, self) if sq.location[0] % 2 == 1
          end
        elsif row > 4
          if row % 2 == 0
            sq.piece = Piece.new(p_one, sq.location, self) if sq.location[0] % 2 == 0
          else
            sq.piece = Piece.new(p_one, sq.location, self) if sq.location[0] % 2 == 1
          end
        end
      end
      row += 1
    end
  end

  def display_board(valid_moves = nil)
    dash_line = "===================================="
    n = 0
    puts "  | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 |"
    puts dash_line
        
    until n == 8
      sq_list = @squares.slice(n*8, 8)
      line = " #{n+1}"
      pos = -1
      8.times do
        pos += 1
        if sq_list[pos].piece
          piece = sq_list[pos].piece.player.color
        elsif valid_moves && valid_moves.include?(sq_list[pos].location)
          piece = "x"
        else
          piece = " "
        end
        line << "| #{piece} "
      end
      line << "|"
      puts line
      puts dash_line
      n += 1
    end
  end

  # Return the square of a given set of coordinates.
  def find_square(c)
    if c.is_a?(String)
      coordinates = c.split("").map{ |x| x.to_i }
    else
      coordinates = c
    end
    list = @squares.select { |sq| sq.location == coordinates }
    list.count == 1 ? list[0] : false
  end

  def empty_square(s)
    square = find_square(s)
    square.piece = nil
  end

end