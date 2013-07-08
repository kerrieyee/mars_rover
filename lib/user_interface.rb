require_relative './navigator'

puts "Please enter the size of the grid "
puts "e.g 5 5  (height width)"
	dimensions = gets.chomp
	until dimensions.match(/\d\s\d/) != nil
		puts "Wrong format, please enter the grid size in the format 5 5."
		dimensions = gets.chomp
	end
	grid_dimensions = dimensions.split(" ")
	navigator = Navigator.new
	navigator.select_grid_size(grid_dimensions[0].to_i, grid_dimensions[1].to_i)
	navigator.grid.grid.each_index do |i|
		p navigator.grid.grid[i]
	end

puts "Would you like to select a rover to move?(y/n)"
	answer = gets.chomp

	while answer.upcase == "Y"
		puts "Please enter the coordinates for your rover."
		puts "e.g 1 3 N (x-coordinate y-coordinate orientation)"
			input = gets.chomp
			until input.match(/\d\s\d\s[N,E,S,W]/i) != nil
				puts "Wrong Format, please enter the coordinates in the format #,#,N."
				puts "The orientation must be one of the letters N, S, E, W." 
				input = gets.chomp
			end

			coordinates = input.split(" ")
			navigator.select_rover(coordinates[0].to_i, coordinates[1].to_i, coordinates[2].upcase)
		puts "Please enter you directions for the rover."
		puts "You can only use the letters L, R, and M." 
		puts "L is to turn the rover left, R to turn the rover right and M move the rover forward." 
		puts "e.g LMRM"
			directions = gets.chomp
			directions.split("").each do |d|
				if ["L","R","M", " "].include?(d.upcase)
					navigator.direct_rover(d)
				else
					raise ArgumentError, "#{d} is not a valid direction.  Directions must be L, R, M"
				end
			end
			navigator.update_position
			puts
			puts "Final position: " + navigator.final_coordinates
			puts
			navigator.grid.grid.each_index do |i|
				p navigator.grid.grid[i]
			end
		puts
		puts "Would you like to move another rover?(y/n)"
			answer = gets.chomp
	end

puts "Goodbye!"
