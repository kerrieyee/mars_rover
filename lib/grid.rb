# A Grid represents a 2d space.
# It has boundaries, width and height (it makes sure these are positive).
# You can probably ask it if a coordinate is within the boundaries or not.
# It can contain objects, for example, a rover; but maybe one day other objects.
# You can ask it if a particular spot is available.
class Grid
  attr_reader :grid, :height, :width

  def initialize(height, width)
    raise Argument Error, "height and width must be greater than 0" if height <0 || width < 0
    @grid = Array.new(height+1){Array.new(width+1)}
    @height = height
    @width = width
  end

  def available?(x, y)
    @grid[x][y] == nil
  end
end
