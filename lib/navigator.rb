require_relative './rover'

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
				@rover.rotate_rover(@rover.orientation, direction)
			when "R"
				@rover.rotate_rover(@rover.orientation, direction)
			when "M"
				@rover.move_to_new_grid(@rover.orientation) 
			else
				raise ArgumentError, "#{direction} is not a valid direction.  Directions must be L, R, M"
			end
		end
		@rover.final_position(@rover.x, @rover.y, @rover.orientation)
	end

end

# navigator = Navigator.new
# navigator.select_grid_size(5,5)
# puts "rover 1"
# navigator.select_rover(1,2,"N")
# navigator.direct_rover("LMLMLMLMM")
# p navigator.rover
# p navigator.rover.grid.grid
# puts 
# puts "rover 2"
# navigator.select_rover(1, 3, "N")
# navigator.direct_rover("MMRMMRMRRM")
# # p navigator.rover
# p navigator.rover.grid.grid