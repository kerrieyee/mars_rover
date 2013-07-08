require_relative './grid'

# A rover has coordinates (x, y) and an orientation on a Grid.
# A rover can turn left or right.
# It can move forward.
# A rover needs to know about a grid, so it can make sure it doesn't move off the grid or into another object on the grid.
# A rover can update the grid with its state.

# The last two responsibilities show some couping with a Grid.
# It isn't bad, but a potential smell.  I'm not sure how I feel about a rover updating the grid in #final_position.
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


  def move
    case @orientation
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

  def turn_left
    if ROTATIONS.first == @orientation
      @orientation = ROTATIONS[-1]
    else
      @orientation = ROTATIONS[(ROTATIONS.index(orientation) - 1)]
    end
  end

  def turn_right
    if ROTATIONS.last == @orientation
      @orientation = ROTATIONS[0]
    else
      @orientation = ROTATIONS[(ROTATIONS.index(@orientation) + 1)]
    end
  end

  private

  # nice methods here.  overall good.  if you change #available? to return false, then you need to handle that here with a new exception
  def decrease_y_coordinate
    raise StandardError, "invalid move coordinate values must be greater than or equal to zero" if @y == 0
    raise StandardError, "Error space is taken by another rover" if !@grid.available?(@x, (@y-1))
    @y -= 1
  end

  def decrease_x_coordinate
    raise StandardError, "invalid move coordinate values must be greater than or equal to zero" if @x == 0
    raise StandardError, "Error space is taken by another rover" if !@grid.available?(@x-1, @y)
    @x -= 1
  end

  def increase_y_coordinate
    raise StandardError, "invalid move: coordinate values cannot exceed the grid size" if @y == @grid.height
    raise StandardError, "Error space is taken by another rover" if !@grid.available?(@x, (@y+1))
    @y+=1
  end

  def increase_x_coordinate
    raise StandardError, "invalid move: coordinate values cannot exceed the grid size" if @x == @grid.width
    raise StandardError, "Error space is taken by another rover" if !@grid.available?(@x+1, @y)
    @x+=1
  end


end
