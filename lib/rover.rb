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

  # i might just rename this to #rotate since you are already calling it on a rover object
  # rover.rotate_rover vs rover.rotate
  # you want your methods to sound like commands.  OOP is a perspective of telling objects to do things.
  def rotate_rover(direction)
    # these new method names should sound more like commands
    # rover.turn_right is telling the rover to do it.  and it should figure it out on its own; ie. you don't need to give it parameters, it should figure it out
    direction == "R" ? turn_right : turn_left
  end

  # this should be more like.  rover.move
  # no argument needed.
  def move_to_new_grid(orientation)
    @grid.grid.reverse[@y][@x] = nil  # why are we doing this here?
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

  # it feels like a rover should update its final position on the grid after any move or rotation method.
  # the way it is now, the navigator is responsble for making sure this method is called.
  # make a branch and see what the code looks like when the rover calls this method, i think it'll seem cleaner
  def final_position(x, y, orientation)
    @grid.grid.reverse[y][x] = orientation
  end

  def coordinates
    "#{@x} #{@y} #{@orientation}"
  end

  private

  # you can make this simpler with modulus operator.  try #turn_right first.
  def turn_left
    if first_element?(ROTATIONS, orientation)
      @orientation = ROTATIONS[-1]
    else
      @orientation = ROTATIONS[(ROTATIONS.index(orientation) - 1)]
    end
  end

  # you can make this simpler if you use a modulus operator
  # the way I read this code, you are saying:
  # to turn right, I have to take the next element in the ROTATIONS array
  # unless I am at the last one, then take the first.
  # this is the same as saying (ROTATIONS.index(orientation) + 1) % ROTATIONS.length
  def turn_right
    if last_element?(ROTATIONS, orientation)
      @orientation = ROTATIONS[0]
    else
      @orientation = ROTATIONS[(ROTATIONS.index(orientation) + 1)]
    end
  end

  # nice methods here.  overall good.  if you change #available? to return false, then you need to handle that here with a new exception
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

  # you can get rid of these methods if you make the modulus changse
  def last_element?(array, element)
    array.index(element) == (array.length - 1)
  end

  def first_element?(array, element)
    array.index(element) == 0
  end

end
