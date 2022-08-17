  require 'pry'
  class Vehicle
    @@wheels = 4

    def self.wheels
      @@wheels
    end
  end

  p Vehicle.wheels                             

  class Motorcycle
    @@wheels = 2
    def self.wheels
      @@wheels
    end
  end

  p Motorcycle.wheels                           
  p Vehicle.wheels                              

  class Car < Vehicle; end

  p Vehicle.wheels
  p Motorcycle.wheels                           
  p Car.wheels