class Grid
  attr_reader :grid, :height, :width

  # why +1?  If I enter 5,5, it should have 5 columns and rows, but it has 6.
  def initialize(height, width)
    @grid = Array.new(height){Array.new(width)}
    @height = height
    @width = width
  end

  # generally methods that end in '?' should only return true/false.  not raise errors.
  def available?(x, y)
    @grid.reverse[y][x] == nil ? true : (raise StandardError, "Error space is taken by another rover")
  end
end
