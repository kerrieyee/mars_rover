class Rover

	attr_reader :x, :y, :orientation

	def initialize(x, y, orientation)
		@x = x
		@y = y
		@orientation = orientation
	end

	
	def move(string)
		directions = string.split("")
		directions.each do |letter|
			if letter == "L"
				rotate_rover(@orientation, letter)
			elsif letter == "R"
				rotate_rover(@orientation, letter)
			elsif letter == "M"
				move_to_new_grid(@orientation)
			end
		end
	end

	private

	def move_to_new_grid(orientation)
		if @orientation == "N"
			@y += 1
		elsif @orientation == "E"
			@x += 1
		elsif @orientation == "S"
			@y -= 1
		elsif @orientation == "W"
			@x -= 1
		end
	end

	def rotate_rover(orientation, direction)
		rotations= ["N", "E", "S", "W"]
		if turn_right?(direction)
			if last_element?(rotations, orientation)
				@orientation = rotations[0]
			elsif 
				@orientation = rotations[(rotations.index(orientation) + 1)] 
			end
		elsif turn_left?(direction)
			if first_element?(rotations, orientation)
				@orientation = rotations[-1]
			elsif 
				@orientation = rotations[(rotations.index(orientation) - 1)] 
			end
		end
	end
	

	def last_element?(array, element)
		array.index(element) == (array.length - 1)
	end

	def first_element?(array, element)
		array.index(element) == 0
	end

	def turn_right?(direction)
		direction == "R"
	end


	def turn_left?(direction)
		direction == "L"
	end
end
	

class Grid
	def initialize(rows, columns)
		@rows = rows
		@columns = columns
	end

	def new_grid
		Array.new(rows, Array.new(@columns))
	end
end


rover = Rover.new(1, 2, "N")
rover.move("LMLMLMLMM")
puts "#{rover.x}, #{rover.y} #{rover.orientation}"
rover = Rover.new(3, 3, "E")
rover.move("MMRMMRMRRM")
puts "#{rover.x}, #{rover.y} #{rover.orientation}"

