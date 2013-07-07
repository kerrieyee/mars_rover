require 'rspec'
require_relative '../lib/navigator'

describe Navigator do
  before(:each) do
    subject.select_grid_size(5,5)
    subject.select_rover(1,2,"N")
  end

  describe "#select_grid_size" do
    it "creates a new grid" do
      subject.grid.should be_a(Grid)
    end
  end

  describe "#select_rover" do
    it "creates a new rover" do
      subject.rover.should be_a(Rover)
    end
  end

  describe "#direct_rover" do
    it "takes valid directions and moves the rover properly" do
      subject.direct_rover("LMLMLMLMM")
      subject.rover.coordinates(subject.rover.x, subject.rover.y, subject.rover.orientation).should eq("1 3 N")
    end

    it "will return an error if the directions are invalid" do
      expect{subject.direct_rover("LMLMxMLMM")}.to raise_error
    end
  end
end
