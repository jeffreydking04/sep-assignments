require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    @width = width
    @height = height
    @matrix = Array.new(width){Array.new(height)}
  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    @matrix[x][y] = pixel if inbounds(x,y)
  end

  def at(x, y)
    return matrix[x][y] if inbounds(x,y)
  end

  private

  def inbounds(x, y)
    x < @width && y < @height && x >= 0 && y >= 0
  end

end

screen = Screen.new(5, 5)
pixel = Pixel.new(128, -54, 3000, 2,3)
screen.insert(pixel, 1, 2)


(0..4).each do |i|
  p screen.matrix[i]
end

p screen.at(2,3)
puts screen.at(1,2)