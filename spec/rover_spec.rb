require 'rspec'
require_relative '../lib/rover'

describe Rover do
  before(:each) do
    @rover = Rover.new(1,1,"N")
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
end
