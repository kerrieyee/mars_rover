require 'rspec'
require_relative '../lib/navigator'

describe Navigator do
  before(:each) do
    subject.select_grid_size(5,5)
    subject.select_rover(1,2,"N")
  end

  its(:grid) { should be_a(Grid) }

  describe "#select_grid_size" do
    it "creates a new grid" do
    	subject.select_grid_size(5, 5)
      subject.instance_variable_get(:@grid).should be_a(Grid)
    end
  end

  describe "#select_rover" do
    it "creates a new rover" do
    	subject.select_rover(1, 2, "N")
      subject.instance_variable_get(:@rover).should be_a(Rover)
    end
  end

  describe "#direct_rover" do
    it "takes valid directions and moves the rover properly" do
      subject.direct_rover("LMLMLMLMM")
      subject.final_coordinates.should eq("1 2 N")
    end

    it "will remove the original position when the rover is moved" do
	    x = subject.rover.x
	    y = subject.rover.y
	    subject.rover.grid.grid.reverse[y][x] = "W"
	    subject.grid.stub(:available?).and_return(true)
	    subject.direct_rover("M")
	    subject.grid.grid.reverse[y][x].should be_nil
	  end
  end

  describe "#clear_old_grid" do
  	it "sets the original square the rover was at to nil" do
  		subject.update_position
  		subject.clear_old_grid
  		subject.grid.grid.reverse[2][1].should eq(nil)
  	end
  end

  describe "#final_coordinates" do
    it "should return the coordinates of the rover" do
      subject.final_coordinates.should eq("1 2 N")
    end
  end


  describe "#update_position" do
    it "should mark the position of the rover on the board" do
    	subject.direct_rover("L")
      subject.update_position
      subject.grid.grid.reverse[2][1].should eq("W")
    end
  end
end
