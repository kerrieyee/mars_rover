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

	until answer.upcase == "N"
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
			navigator.direct_rover(directions.upcase)
			puts
			puts "Final position: " + navigator.rover.coordinates(navigator.rover.x, navigator.rover.y, navigator.rover.orientation)
			puts
			navigator.grid.grid.each_index do |i|
				p navigator.grid.grid[i]
			end
		puts
		puts "Would you like to move another rover?(y/n)"
			answer = gets.chomp
	end

puts "Goodbye!"