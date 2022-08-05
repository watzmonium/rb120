# module Speak
#   def speak(sound)
#     puts "#{sound}"
#     puts "Boi"
#   end
# end

class GoodDog
  # include Speak
  # this initialize is a key word that has specific functionality in ruby
  # it always runs when you make a new object of this class
  # We refer to the initialize method as a constructor, because 
  # it is a special method that builds the object when a new 
  # object is instantiated. It gets triggered by the new class method.
  def initialize(name)
    # instance variable
    @name = name
  end

  def speak
    "#{@name} says arf"
  end

  def get_name
    @name
  end
  # setter method
  def set_name=(name)
    @name = name
  end
end

# intatitating a new GoodDog object
a = GoodDog.new('poop') # calling new method on gooddog instatitates the object and cals the constructor
sparky = GoodDog.new('sparky')
puts a.speak
a.set_name = 'goop'

puts a.get_name
puts sparky.speak
