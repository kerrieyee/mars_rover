require_relative './rover'

# Make sure you know what each class is responsible for and put it in a comment at the top.
# This helps you spot when one class is doing too much or doing something it shouldn't.
# This helps maintain the Single Responsibility Principle of OOP.
#
# A navigator builds the grid from user input.
# A navigator builds a rover from user input.
# A navigator takes user input, and sends directions to a Rover.
# A navigator calls Rover#final_position to tell it to update the grid.

# When I write this out, it seems like #final_position should be a navigator method.
# The navigator already knows about the grid and the rover.  He is like the middleman who knows both.
# And updating a grid with a rover position is logic that needs to know both.
class Navigator
  attr_reader :rover, :grid

  def select_grid_size(grid_height, grid_width)
    @grid = Grid.new(grid_height, grid_width)
  end

  def select_rover(x, y, orientation)
    @rover = Rover.new(x, y, orientation, @grid)
  end

  def direct_rover(directions)
    directions.split("").each do |direction|
      case direction
      when "L"
        @rover.rotate_rover(direction)
      when "R"
        @rover.rotate_rover(direction)
      when "M"
        @rover.move_to_new_grid(@rover.orientation)
      else
        raise ArgumentError, "#{direction} is not a valid direction.  Directions must be L, R, M"
      end
    end
    @rover.final_position(@rover.x, @rover.y, @rover.orientation)
  end
end
