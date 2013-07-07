require 'rspec'
require_relative '../lib/navigator'

describe Navigator do
  before(:each) do
    subject.select_grid_size(5,5)
    subject.select_rover(1,2,"N")
  end

  its(:grid) { should be_a(Grid) }

  # this spec is phrased a bit oddly.  are you testing #select_grid_size?  it seems like you are testing #grid.
  # you should probably test #select_grid_size directly to make sure it instantiates a grid and assigns it (you are kinda doing that indirectly by testing #grid)
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

  # this is nice overall nice; one refactor though - it is weird that you have rover#coordinates take the rover itself as an argument.
  # this is a code smell.  you shoudn't need to pass attributes of the object to a method of the object.
  describe "#direct_rover" do
    it "takes valid directions and moves the rover properly" do
      subject.direct_rover("LMLMLMLMM")
      subject.rover.coordinates.should eq("1 3 N")
    end

    it "will return an error if the directions are invalid" do
      expect{subject.direct_rover("LMLMxMLMM")}.to raise_error
    end
  end
end
