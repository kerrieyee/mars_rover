require 'rspec'
require '../rover.rb'


describe Rover do 
	context "if the input is correct" do
		let(:rover){Rover.new(1,1, "N")}

		it "should rotate the rover left if the direction given is L" do
			rover.move("L")
			rover.orientation.should eq("W")
		end

		it "should rotate the rover right if the direction given is R" do
			rover.move("R")
			rover.orientation.should eq("E")
		end

		it "should rotate to the left and move left if directions are LM" do
			rover.move("LM")
			rover.orientation.should eq("W")
			rover.x.should eq(0)
		end
	end
end

