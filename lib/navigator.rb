require_relative './rover'

# A navigator builds the grid from user input.
# A navigator builds a rover from user input.
# A navigator takes user input, and sends directions to a Rover.
# A navigator calls Rover#final_position to tell it to update the grid.
# A navigator needs to know about a grid, so it can make sure it doesn't move off the grid or into another object on the grid.
# A navigator can update the grid with the rover's state.

class Navigator
  attr_reader :rover, :grid

  def select_grid_size(grid_height, grid_width)
    @grid = Grid.new(grid_height, grid_width)
  end

  def select_rover(x, y, orientation)
    @rover = Rover.new(x, y, orientation)
  end

  def direct_rover(direction)
    case direction
    when "L"
      @rover.turn_left
    when "R"
      @rover.turn_right
    when "M"
      clear_old_grid
      move
    end
    p direction
  end

  def move
    case @rover.orientation
    when "N"
      move_y
    when "E"
      move_x
    when "S"
      move_y
    when "W"
      move_x
    end
  end

  def move_x
    if @rover.orientation == "E"
      raise StandardError, "invalid move: coordinate values cannot exceed the grid size" if @rover.x + 1 > @grid.width
      raise StandardError, "Error space is taken by another rover" if !@grid.available?((@rover.x+1), @rover.y)
      @rover.increase_x_coordinate
    else
      raise StandardError, "invalid move coordinate values must be greater than or equal to zero" if @rover.x - 1<0
      raise StandardError, "Error space is taken by another rover" if !@grid.available?((@rover.x-1), @rover.y)
      @rover.decrease_x_coordinate
    end
  end

  def move_y
    if @rover.orientation == "N"
      raise StandardError, "invalid move: coordinate values cannot exceed the grid size" if @rover.y + 1 > @grid.height
      raise StandardError, "Error space is taken by another rover" if !@grid.available?(@rover.x, (@rover.y+1))
      @rover.increase_y_coordinate
    else
      raise StandardError, "invalid move coordinate values must be greater than or equal to zero" if @rover.y - 1 < 0
      raise StandardError, "Error space is taken by another rover" if !@grid.available?(@rover.x, (@rover.y-1))
      @rover.decrease_y_coordinate
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
