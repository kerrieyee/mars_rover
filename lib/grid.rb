class Grid
  attr_reader :grid, :height, :width

  # why +1?  If I enter 5,5, it should have 5 columns and rows, but it has 6.
  def initialize(height, width)
    @grid = Array.new(height){Array.new(width)}
    @height = height
    @width = width
  end

  # generally methods that end in '?' should only return true/false.  not raise errors.
  # the difference here is important.  one is like asking a question, is this spot available?  yes or not.
  # you would raise an error when you tell an object to do something, but it can't.
  # that is more like, rover.move_here # => error, i can't move there because it is taken.
  def available?(x, y)
    @grid[x][y] == nil ? true : (raise StandardError, "Error space is taken by another rover")
  end
end
