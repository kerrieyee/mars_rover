# Make sure you know what each class is responsible for and put it in a comment at the top.
# This helps you spot when one class is doing too much or doing something it shouldn't.
# This helps maintain the Single Responsibility Principle of OOP.
#
# A Grid represents a 2d space.
# It has boundaries, width and height (it makes sure these are positive).
# You can probably ask it if a coordinate is within the boundaries or not.
# It can contain objects, for example, a rover; but maybe one day other objects.
# You can ask it if a particular spot is available.
class Grid
  attr_reader :grid, :height, :width

  # why +1?  If I enter 5,5, it should have 5 columns and rows, but it has 6.
  def initialize(height, width)
    # should validate that height and width are >0, raise an error otherwise.
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
