class Vehicle
  attr_reader :make, :model

  def initialize(make, model)
    @make = make
    @model = model
  end

  def to_s
    "#{make} #{model}"
  end
  def wheels
    2
  end
end

class Car < Vehicle

  def wheels
    super() + 2
  end

end

class Motorcycle < Vehicle
end

class Truck < Vehicle
  attr_reader :payload

  def initialize(make, model, payload)
    super(make, model)
    @payload = payload
  end

  def wheels
    super() + 4
  end
end

chevy = Truck.new('chevy', 'poopsicle', 100)
puts chevy.wheels