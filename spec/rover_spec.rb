require 'rspec'
require_relative '../lib/rover'

describe Rover do
  before(:each) do
    @grid = mock(Grid)
    @grid.stub(:height).and_return(5)
    @grid.stub(:width).and_return(5)
    @grid.stub(:grid).and_return(Array.new(@grid.height + 1){Array.new(@grid.width + 1)})
    @rover = Rover.new(1,1,"N", @grid)
  end

  describe "#turn_left" do
    it "rotates the rover left if the direction given is L" do
      @rover.turn_left
      @rover.orientation.should eq("W")
    end
  end

  describe "#turn_right" do
    it "rotates the rover right if the direction given is R" do
      @rover.turn_right
      @rover.orientation.should eq("E")
    end
  end

  context "moves are valid" do
    describe "#move_to_new_grid" do
      it "move the rover forward depending on it's orientation" do
        @grid.stub(:available?).and_return(true)
        @rover.move
        @rover.y.should eq(2)
      end
    end
  end

  context "moves are not valid" do
    describe "#move" do
      it "raises an error if the rover tries to move off the south edge of the grid" do
        rover = Rover.new(0,0, "N", @grid)
        expect{@rover.move}.to raise_error
      end

      it "raises an error if the rover tries to move off the north edge of the moves_to_new_grid" do
        rover = Rover.new(5,5, "N", @grid)
        expect{rover.move}.to raise_error
      end

      it "raises an error if the rover tries to move off the east edge of the grid" do
        rover = Rover.new(5,5, "N", @grid)
        expect{rover.move}.to raise_error
      end
      it "raises an error if the rover tries to move off the west edge of the grid" do
        rover = Rover.new(0,0, "N", @grid)
        expect{@rover.move}.to raise_error
      end
    end
  end

end
