class Animal
  def speak
    "meow"
  end
end

class Dog < Animal
end

class Cat < Animal
end

poop = Dog.new
meepo = Cat.new

puts meepo.speak
puts poop.speak