require_relative './grid'

# A rover has coordinates (x, y) and an orientation on a Grid.
# A rover can turn left or right.
# It can move forward.


class Rover
  attr_reader :x, :y, :orientation
  ROTATIONS = ["N", "E", "S", "W"]

  def initialize(x, y, orientation)
    @x = x
    @y = y
    @orientation = orientation
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

  def decrease_y_coordinate
    @y -= 1
  end

  def decrease_x_coordinate
    @x -= 1
  end

  def increase_y_coordinate
    @y+=1
  end

  def increase_x_coordinate
    @x+=1
  end


end
