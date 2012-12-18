require_relative './grid'

class Rover

	attr_reader :x, :y, :orientation
	attr_accessor :grid

	def initialize(x, y, orientation, grid)
		@x = x
		@y = y
		@orientation = orientation
		@grid = grid
	end

	def rotate_rover(orientation, direction)
		rotations= ["N", "E", "S", "W"]
		direction == "R" ? turn_right(rotations, orientation) : turn_left(rotations, orientation)
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

	def coordinates(x, y, orientation)
		"x: #{@x}, y: #{@y}, orientation: #{@orientation}"
	end

	private 

	def turn_left(array, orientation)
		if first_element?(array, orientation)
			@orientation = array[-1]
		else
			@orientation = array[(array.index(orientation) - 1)] 
		end
	end

	def turn_right(array, orientation)
		if last_element?(array, orientation)
			@orientation = array[0]
		else
			@orientation = array[(array.index(orientation) + 1)] 
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
	


# grid = Grid.new(5,5)
# rover = Rover.new(5, 5, "N", grid)
# rover.move_to_new_grid("S")
# rover.final_position(5, 4, "S")
# puts "#{rover.x}, #{rover.y} #{rover.orientation}"
# p rover.grid.grid

# puts "rover 2"
# rover2 = Rover.new(5, 5, "E", grid)
# rover2.move_to_new_grid("S")
# rover.final_position(5, 4, "S")
# p rover2.grid.grid
# puts "#{rover.x}, #{rover.y} #{rover.orientation}"

