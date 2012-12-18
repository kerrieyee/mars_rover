require 'rspec'
require '../lib/rover.rb'


describe Rover do 
	before(:each) do
		@grid = mock(Grid)
		@grid.stub(:height).and_return(5)
		@grid.stub(:width).and_return(5)
		@grid.stub(:grid).and_return(Array.new(@grid.height + 1){Array.new(@grid.width + 1)})
		@rover = Rover.new(1,1,"N", @grid)
	end

	describe "#rotate_rover" do

		it "rotates the rover left if the direction given is L" do
			@rover.rotate_rover(@rover.orientation, "L")
			@rover.orientation.should eq("W")
		end

		it "rotates the rover right if the direction given is R" do
			@rover.rotate_rover(@rover.orientation, "R")
			@rover.orientation.should eq("E")
		end
	end
	context "moves are valid" do
		describe "#move_to_new_grid" do
			it "will remove the original position if the same bot is selected twice to move " do
				x = @rover.x
				y = @rover.y
				@rover.grid.grid.reverse[y][x] = "W"
				@grid.stub(:available?).and_return(true)
				@rover.move_to_new_grid("N")
				@rover.grid.grid.reverse[y][x].should be_nil
			end

			it "move the rover forward depending on it's orientation" do
				@grid.stub(:available?).and_return(true)
				@rover.move_to_new_grid("W")
				@rover.x.should eq(0)
			end
		end
	end

	context "moves are not valid" do
		describe "#moves_to_new_grid" do
			it "raises an error if the rover tries to move off the south edge of the grid" do
				rover = Rover.new(0,0, "N", @grid)
				expect{@rover.move_to_new_grid("S")}.to raise_error
			end

			it "raises an error if the rover tries to move off the north edge of the moves_to_new_grid" do
				rover = Rover.new(5,5, "N", @grid)
				expect{rover.move_to_new_grid("N")}.to raise_error
			end

			it "raises an error if the rover tries to move off the east edge of the grid" do
				rover = Rover.new(5,5, "N", @grid)
				expect{rover.move_to_new_grid("E")}.to raise_error
			end
			it "raises an error if the rover tries to move off the west edge of the grid" do
				rover = Rover.new(0,0, "N", @grid)
				expect{@rover.move_to_new_grid("W")}.to raise_error
			end
		end
	end


	describe "#final_position" do
		it "should mark the final position of the rover on the board" do
			@rover.final_position(1, 1, "N")
			@rover.grid.grid.reverse[1][1].should eq("N")
		end
	end

	describe "#coordinates" do 
		it "should return the coordinates of the rover" do
			@rover.coordinates(1, 1, "N").should eq("x: 1, y: 1, orientation: N")
		end
	end
end

