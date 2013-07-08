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

  def direct_rover(direction)
    case direction
    when "L"
      @rover.turn_left
    when "R"
      @rover.turn_right
    when "M"
      clear_old_grid
      @rover.move
    end
  end

  def clear_old_grid
    @grid.grid.reverse[@rover.y][@rover.x] = nil
  end

  def update_position
    @grid.grid.reverse[@rover.y][@rover.x] = @rover.orientation
  end

  def final_coordinates
    "#{@rover.x} #{@rover.y} #{@rover.orientation}"
  end
end
