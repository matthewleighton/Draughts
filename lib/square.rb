class Square
  attr_accessor :location, :piece

  def initialize(coordinates)
    @location = coordinates
    @piece = nil
  end
end