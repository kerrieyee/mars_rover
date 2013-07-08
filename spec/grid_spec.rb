require 'rspec'
require_relative '../lib/grid'

describe Grid do
  describe "#initialize" do
    subject { Grid.new(5,5) }

    it "should have a width of 5" do
      subject.grid.length.should == 6
    end

    it "should have a height of 5" do
      subject.grid[0].length.should == 6
    end
  end

  describe "#available?" do
    subject { Grid.new(6,6) }

    it "returns true if the grid is empty" do
      subject.available?(3,3).should eq(true)
    end

    it "returns false if the grid is already taken" do
      subject.grid[3][3] = "N"
      subject.available?(3,3).should be false
    end
  end
end
