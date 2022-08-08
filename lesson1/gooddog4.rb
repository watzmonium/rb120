module Swimmable
  def swim
    "I'm swimming!"
  end
end

class Animal
  attr_accessor :name
  def initialize(name)
    @name = name
  end

  def speak
    "Hello!"
  end
end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal
end

class GoodDog < Mammal
  attr_accessor :age
  def initialize(age, name)
    super(name)
    @age = age
  end

  include Swimmable

  def speak
    # SUPER!!!!
    super + " from GoodDog class"
  end
end

p sparky = GoodDog.new(3, "gorp")
p sparky.speak        # => "Hello! from GoodDog class"
p sparky.name, sparky.age
p sparky.swim