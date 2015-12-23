require 'spec_helper'

describe "board object" do
  before :each do
    @board = Board.new
  end

  describe "#initialize" do
    
    it "creates a new board" do
      expect(@board).to be_a(Board)
    end

    it "has 64 squares" do
      expect(@board.squares.count).to eq(64)
    end

  end

  describe "#place_pieces" do

    before :each do
      @player_one = Player.new("one", "B", @board)
      @player_two = Player.new("two", "W", @board)
      @board.place_pieces(@player_one, @player_two)
    end
    
    it "places 24 pieces" do
      expect(@board.squares.select{|sq| sq.piece }.count).to eq(24)
    end

    it "creates 12 white pieces" do
      expect(@board.squares.select{|sq| sq.piece and sq.piece.player.color == "W"}.count).to eq(12)
    end

    it "creates 12 black pieces" do
      expect(@board.squares.select{|sq| sq.piece and sq.piece.player.color == "B"}.count).to eq(12)
    end
  end

  describe "#find_square" do

    it "returns the correct square" do
      expect(@board.find_square("34").location).to eq([3, 4])
    end

    it "returns false if the square doesn't exist" do
      expect(@board.find_square("89")).to eq(false)
    end

  end

end