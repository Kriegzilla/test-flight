require_relative "../../lib/airplane"
require "rspec"
require "pry"

# let(:my_plane) do
#   type = "cesna"
#   wing_loading = 10
#   horsepower = 150
#   Airplane.new(type, wing_loading, horsepower)
# end

describe Airplane do

  let(:my_plane) do
    type = "cesna"
    wing_loading = 10
    horsepower = 150
    fuel = 10
    Airplane.new(type, wing_loading, horsepower, fuel)
  end


  describe "#initialization" do
    it "creates a new plane" do
      expect(my_plane).to be_a(Airplane)
    end

    it "reads the type" do
      expect(my_plane.type).to eq("cesna")
    end

    it "reads the wing loading" do
      expect(my_plane.wing_loading).to eq(10)
    end

    it "reads the horsepower" do
      expect(my_plane.horsepower).to eq(150)
    end

  end

  describe "#land" do

    it "tells us we haven't started yet" do
      expect { my_plane.land }.to output("Engines have not started yet\n").to_stdout
    end

    it "tells us we haven't taken off yet" do
      my_plane.start
      expect { my_plane.land }.to output("We have not taken off yet\n").to_stdout
    end

    it "lands the plane" do
      my_plane.start
      my_plane.takeoff
      expect { my_plane.land }.to output("A successful landing!\n").to_stdout
    end

  end

  describe "#takeoff" do

    it "will not take off if the engines are off" do
      expect { my_plane.takeoff }.to output("Engines are off, please start\n").to_stdout
    end

    it "takes off if the engines are started" do
      my_plane.start
      expect { my_plane.takeoff }.to output("LAUNCHING!\n").to_stdout
    end

    it "will not take off if we're already flying" do
      my_plane.start
      my_plane.takeoff
      expect { my_plane.takeoff }.to output("Already flying\n").to_stdout
    end

  end

  describe "#start" do

    it "engines begin off" do
      expect(my_plane.engines_on).to be false
    end

    it "starts the engine" do
      expect { my_plane.start }.to output("Engines started!\n").to_stdout
    end

    it "is already started" do
      my_plane.start
      expect { my_plane.start }.to output("Airplane is already started!\n").to_stdout
    end

  end

  describe "#fuel_check" do

    it "contains fuel" do
      expect(my_plane.empty? ).to be false
    end

    it "reduces fuel on start" do
      fuel = my_plane.fuel
      my_plane.start
      expect(my_plane.fuel).to eq(fuel-1)
    end

    it "reduces fuel on takeoff" do
      my_plane.start
      fuel = my_plane.fuel
      my_plane.takeoff
      expect(my_plane.fuel).to eq(fuel-1)
    end

    it "reduces fuel on landing" do
      my_plane.start
      my_plane.takeoff
      fuel = my_plane.fuel
      my_plane.land
      expect(my_plane.fuel).to eq(fuel-1)
    end

    it "is on the ground with no fuel" do
      empty_plane = Airplane.new("cesna", 10, 150, 0)
      expect { empty_plane.fuel_failure }.to output("The plane has no fuel!\n").to_stdout
    end

    it "fails to start if there's no fuel" do
      empty_plane = Airplane.new("cesna", 10, 150, 0)
      expect { empty_plane.start }.to output("The plane has no fuel!\n").to_stdout
    end

    it "fails to takeoff if there's no fuel" do
      empty_plane = Airplane.new("cesna", 10, 150, 1)
      empty_plane.start
      expect { empty_plane.takeoff }.to output("The plane has no fuel!\n").to_stdout
    end

    it "fails if land there's no fuel" do
      empty_plane = Airplane.new("cesna", 10, 150, 2)
      empty_plane.start
      empty_plane.takeoff
      expect { empty_plane.land }.to output("THE PLANE HAS NO FUEL!!!!! AHHHHH!!!!\n").to_stdout
    end

  end

end
