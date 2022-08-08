class Pet

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Cat < Pet
  def fetch
    "can't fetch!"
  end

  def swim
    "can't swim!"
  end

  def speak
    'meow'

  end

end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class BullDog < Dog
  def swim
    'cant swim!'
  end
end

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = BullDog.new

p pete.run                # => "running!"
#p pete.speak              # => NoMethodError

p kitty.run               # => "running!"
p kitty.speak             # => "meow!"
p kitty.fetch             # => NoMethodError

p dave.speak              # => "bark!"

p bud.run                 # => "running!"
p bud.swim                # => "can't swim!"