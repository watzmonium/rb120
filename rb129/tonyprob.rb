# Challenge: find a way to initiate instance variable `name` for `Cat`, `Dog`, and `Roomba` with the 
# module `Namable`. Use the `Animal` and `Roomba` class to initiate the `type` instance variable


#Note: it's bad practice to use initialize method from within the module. Don't do that!


module Namable
  def name(name, type)
    @name = name
    @type = type
  end
end

class Animal
  include Namable
  def initialize(name, type)
    name(name, type)
  end
end

class Cat < Animal
end

class Dog < Animal
end

class Roomba
  include Namable
  def initialize(name, type)
    name(name, type)
  end
end

# Do not modify below  ####
puts 'hi'
a = gets.chomp
dog = Dog.new(a, "organic") # (name, type)
cat = Cat.new("catty", "organic")
robo = Roomba.new("walle", "robotic")

# Return values should be as follows: 

p dog #<Dog:0x0000555a6202b158 @type="organic", @name="doggy">
p cat #<Cat:0x0000555a6202b090 @type="organic", @name="catty">
p robo #<Roomba:0x0000555a6202ad20 @type="robotic", @name="walle">