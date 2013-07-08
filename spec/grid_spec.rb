require 'rspec'
require_relative '../lib/grid'

describe Grid do
  describe "#initialize" do
    context "has valid width and height" do
      subject { Grid.new(5,5) }

      it "should have a width of 6" do
        subject.grid.length.should == 6
      end

      it "should have a height of 6" do
        subject.grid[0].length.should == 6
      end
    end

    context "has invalid width and height" do
      it "should raise an error if the height is invalid" do
        expect{Grid.new(-5,1)}.to raise_error
      end

      it "should raise an error if the width is invalid" do
        expect{Grid.new(5,-1)}.to raise_error
      end
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
