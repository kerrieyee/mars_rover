require_relative './grid'

class Rover
  attr_reader :x, :y, :orientation
  attr_accessor :grid
  ROTATIONS = ["N", "E", "S", "W"]

  def initialize(x, y, orientation, grid)
    @x = x
    @y = y
    @orientation = orientation
    @grid = grid
  end

  def rotate_rover(orientation, direction)
    direction == "R" ? turn_right(orientation) : turn_left(orientation)
  end

  def move_to_new_grid(orientation)
    @grid.grid.reverse[@y][@x] = nil
    case orientation
    when "N"
      increase_y_coordinate
    when "E"
      increase_x_coordinate
    when "S"
      decrease_y_coordinate
    when "W"
      decrease_x_coordinate
    end
  end

  def final_position(x, y, orientation)
    @grid.grid.reverse[y][x] = orientation
  end

  def coordinates
    "#{@x} #{@y} #{@orientation}"
  end

  private

  def turn_left(orientation)
    if first_element?(ROTATIONS, orientation)
      @orientation = ROTATIONS[-1]
    else
      @orientation = ROTATIONS[(ROTATIONS.index(orientation) - 1)]
    end
  end

  def turn_right(orientation)
    if last_element?(ROTATIONS, orientation)
      @orientation = ROTATIONS[0]
    else
      @orientation = ROTATIONS[(ROTATIONS.index(orientation) + 1)]
    end
  end

  def decrease_y_coordinate
    raise StandardError, "invalid move coordinate values must be greater than or equal to zero" if @y == 0
    @y -= 1 if @grid.available?(@x, (@y-1))
  end

  def decrease_x_coordinate
    raise StandardError, "invalid move coordinate values must be greater than or equal to zero" if @x == 0
    @x -= 1 if @grid.available?(@x-1, @y)
  end

  def increase_y_coordinate
    raise StandardError, "invalid move: coordinate values cannot exceed the grid size" if @y == @grid.height
    @y+=1 if @grid.available?(@x, (@y+1))
  end

  def increase_x_coordinate
    raise StandardError, "invalid move: coordinate values cannot exceed the grid size" if @x == @grid.width
    @x+=1 if @grid.available?(@x+1, @y)
  end

  def last_element?(array, element)
    array.index(element) == (array.length - 1)
  end

  def first_element?(array, element)
    array.index(element) == 0
  end

end
