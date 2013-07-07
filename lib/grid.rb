class Grid
  attr_reader :grid, :height, :width

  def initialize(height, width)
    @grid = Array.new(height + 1){Array.new(width + 1)}
    @height = height
    @width = width
  end

  def available?(x, y)
    @grid.reverse[y][x] == nil ? true : (raise StandardError, "Error space is taken by another rover")
  end
end
