require 'rspec'
require '../lib/navigator.rb'

describe Navigator do 
	let(:navigator){Navigator.new}
	before(:each) do
		navigator.select_grid_size(5,5)
		navigator.select_rover(1,2,"N")
	end

	describe "#select_grid_size" do
		it "creates a new grid" do
			navigator.grid.should be_a(Grid)
		end
	end

	describe "#select_rover" do
		it "creates a new rover" do			
			navigator.rover.should be_a(Rover)
		end
	end

	describe "#direct_rover" do
		it "takes valid directions and moves the rover properly" do
			navigator.direct_rover("LMLMLMLMM")
			navigator.rover.coordinates(navigator.rover.x, navigator.rover.y, navigator.rover.orientation).should eq("x: 1, y: 3, orientation: N")
		end

		it "will return an error if the directions are invalid" do
			expect{navigator.direct_rover("LMLMmMLMM")}.to raise_error
		end
	end

end