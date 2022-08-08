class Vehicle
  attr_reader :year

  def initialize(year)
    @year = year
  end

  def start_engine
    'Ready to go!'
  end
end

class Car < Vehicle

end

class Truck < Vehicle
  attr_accessor :bed_type
  def initialize(year, type)
    super(year)
    @bed_type = type
  end

  def start_engine(speed)
    "#{super()} Go #{speed} please"
  end
end

truck1 = Truck.new(1994, 'short')
puts truck1.year, truck1.bed_type

car1 = Car.new(2006)
puts car1.year

puts truck1.start_engine('fast')