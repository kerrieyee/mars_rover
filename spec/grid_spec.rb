require 'rspec'
require_relative '../lib/grid'

describe Grid do
  describe "#initialize" do
    subject { Grid.new(5,5) }

    it "should have a width of 5" do
      subject.grid.length.should == 5
    end

    it "should have a height of 5" do
      subject.grid[0].length.should == 5
    end
  end

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
