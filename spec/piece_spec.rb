require 'spec_helper'

describe "Piece object" do
  before :each do 
    @board = Board.new
    @player = Player.new("Matthew", "W", @board)
    @piece = Piece.new(@player, [3, 2])
  end

  describe "#is_friendly?" do

    it "returns true if piece belongs to player" do
      expect(@piece.is_friendly?(@player)).to eq(true)
    end

    it "returns false if piece does not belong to player" do
      other_player = Player.new("Charlie", "B", @board)
      expect(@piece.is_friendly?(other_player)).to eq(false)
    end

  end

  describe "#valid_moves" do

    before :each do
      @piece.location = [5, 5]
      @piece.update_board(@board)
      @other_player = Player.new("Charlie", "B", @board)
      @e_one = Piece.new(@other_player, [4, 6])
      @e_one.update_board(@board)
      @e_two = Piece.new(@other_player, [3, 7])
      @e_two.update_board(@board)
      @e_three = Piece.new(@other_player, [6, 6])
      @e_three.update_board(@board)
      @e_four = Piece.new(@other_player, [7, 7])
      @e_four.update_board(@board) 
    end

    it "returns false if piece faces two enemies on both sides" do
      expect(@piece.valid_moves(@board)).to eq(false)
    end

    it "returns one space if piece faces two enemies on right, one on left" do
      @e_two.remove_piece(@board)
      expect(@piece.valid_moves(@board)).to eq([[3, 7]])
    end

    it "returns one space if piece faces two enemies on left, one on right" do
      @e_four.remove_piece(@board)
      expect(@piece.valid_moves(@board)).to eq([[7, 7]])
    end

    it "returns two spaces if piece can take enemy on either side" do
      @e_two.remove_piece(@board)
      @e_four.remove_piece(@board)
      expect(@piece.valid_moves(@board)).to eq([[3, 7], [7, 7]])
    end

    it "returns two spaces if piece can either move or take enemy" do
      @e_one.remove_piece(@board)
      @e_two.remove_piece(@board)
      @e_four.remove_piece(@board)
      expect(@piece.valid_moves(@board)).to eq([[4, 6], [7, 7]])
    end

    it "returns two spaces if piece can move in either direction" do
      @e_two.remove_piece(@board)
      @e_four.remove_piece(@board)
      expect(@piece.valid_moves(@board)).to eq([[3, 7], [7, 7]])
    end

    it "returns one space if piece is against edge of board" do
      @piece.location = [8, 5]
      @piece.update_board(@board)
      expect(@piece.valid_moves(@board)).to eq([[7, 6]])
    end

    it "can't jump enemy at edge of board" do
      @piece.location = [7, 1]
      @piece.update_board(@board)
      enemy = Piece.new(@other_player, [8, 2])
      enemy.update_board(@board)
      expect(@piece.valid_moves(@board)).to eq([[6, 2]])
    end
  end

  describe "#update_board" do
    
    before :each do
      @piece = Piece.new(@player, [4, 4])
      @piece.update_board(@board)
     
    end

   

  end
end