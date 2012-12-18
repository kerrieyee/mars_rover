require 'rspec'
require_relative '../lib/grid'

describe Grid do 
	describe "#available?" do
		let(:grid){Grid.new(6,6)}
		
		it "returns true if the grid is empty" do
			grid.available?(3,3).should eq(true)
		end 


		it "raises an error if the grid is already taken" do
			grid.grid[3][3] = "N"
			expect{grid.available?(3,3)}.to raise_error
		end
	end
end