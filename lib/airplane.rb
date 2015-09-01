class Airplane

  attr_reader :type, :wing_loading, :horsepower, :engines_on, :status, :fuel

  def initialize (type, wing_loading, horsepower, fuel)
    @type = type
    @wing_loading = wing_loading
    @horsepower = horsepower
    @engines_on = false
    @status = "grounded"
    @fuel = fuel
  end

  def start
    if fuel_failure
    elsif engines_on == false
      @engines_on = true
      @fuel -= 1
      puts "Engines started!"
    else
      puts "Airplane is already started!"
    end
  end

  def takeoff
    if fuel_failure
    elsif engines_on == false
      puts "Engines are off, please start"
    elsif status == "grounded"
      @status = "flying"
      @fuel -= 1
      puts "LAUNCHING!"
    else
      puts "Already flying"
    end
  end

  def land
    if fuel_failure
    elsif engines_on == false
      puts "Engines have not started yet"
    elsif status == "grounded"
      puts "We have not taken off yet"
    else
      @status == "grounded"
      @fuel -= 1
      puts "A successful landing!"
    end
  end

  def empty?
    fuel <= 0
  end

  def fuel_failure
    if empty? && @status == "grounded"
      puts "The plane has no fuel!"
      return true
    elsif empty? && @status == "flying"
      puts "THE PLANE HAS NO FUEL!!!!! AHHHHH!!!!"
      return true
    end
  end

end
