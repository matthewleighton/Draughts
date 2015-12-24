require_relative 'board'
require_relative 'player'
require_relative 'human_player'
require_relative 'ai_player'

class Draughts
  attr_accessor :player_count, :players, :player_one, :player_two, :board

  def initialize
    @board = Board.new
    @players = []
  end

  def start
    puts "-----Welcome to Draughts 2015!-----\n\n"
    @player_count = get_player_count
    @players << @player_one = get_new_player("h", @board)
    @players << @player_two = get_new_player(player_count == 1 ? "c" : "h", @board)
    @board.place_pieces(@player_one, @player_two)
    play_game
    finish_game
  end

  def play_game
    puts ""
    @board.display_board
    until game_over?
      @players.each do |player|
        break if game_over?
        player.turn
      end
    end
  end

  def game_over?
    return true if (@player_one.remaining_pieces == 0) || (@player_two.remaining_pieces == 0)
  end

  def finish_game
    print @player_one.remaining_pieces ? "\n#{@player_one.name} " : "\n#{@player_two.name} "
    print "wins! Goodbye."
  end

  def get_player_count
    player_count = 0
    until player_count.between?(1, 2)
      print "Enter number of players: "
      player_count = gets.chomp.to_i
    end

    player_count
  end

  def get_new_player(type, board)
    if type == "h"
      color = @players.count == 0 ? "b" : "w"
      player = HumanPlayer.new(get_player_name, color, board)
    else
      player = AiPlayer.new
    end

    player
  end

  def get_player_name
    name = ""
    while name.length < 1
      if @player_count == 2
        if !@player_one
          print "Player one, e"
        else
          print "Player two, e"
        end
      else
        print "E"
      end
      print "nter your name: "
      name = gets.chomp.strip
    end

    name
  end

end

game = Draughts.new

