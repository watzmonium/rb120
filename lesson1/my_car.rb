module Jumpable
  def jump
    "YEEEEHAAAAWWW"
  end
end

class Vehicle
  attr_accessor :color, :speed
  attr_reader :year, :model

  @@num_of_vehicles = 0

  def initialize(y, c, m)
    @@num_of_vehicles += 1
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def to_s
    "A #{year}, #{color} #{model}"
  end

  def self.num_of_vehicles
    @@num_of_vehicles
  end

  def speed_up(speed)
    self.speed = speed
  end

  def brake(s)
    self.speed -= s
  end

  def turn_off
    self.speed = 0
  end

  # this is an instance method
  def spray_paint(c)
    self.color = c
  end

  # this is a class method
  def self.milage(driven, gallons)
    "#{driven/gallons} miles per gallon of gas"
  end

  def how_old?
    "your #{year} #{model} is #{age} years old"
  end

  private

  def age
    Time.now.year - self.year.to_i
  end
end

class MyTruck < Vehicle
  THIS_TRUCK = ['Pickups', '4x4s', 'SUVs']
  include Jumpable
end

class MyCar < Vehicle
  
  THIS_CAR = ['Sedans', 'Hactchbacks', 'Coupes']

  
end

civic = MyCar.new('2003', 'Black', 'Civic')
poop = MyTruck.new('2003', 'Black', 'Civic')
durango = MyTruck.new('2003', 'Black', 'Civic')
civic.spray_paint('blue')
puts civic.color
puts civic
p durango.jump

puts civic.how_old?
p MyCar.num_of_vehicles
puts MyCar.milage(371, 13)

puts MyCar.ancestors
puts MyTruck.ancestors
# puts civic.speed
# civic.speed_up(60)
# puts civic.speed
# civic.brake(40)
# puts civic.speed
# civic.turn_off
# puts civic.speed

# puts civic.color
# civic.color = 'Blue'
# puts civic.color
# puts civic.year
# civic.year = '2001'