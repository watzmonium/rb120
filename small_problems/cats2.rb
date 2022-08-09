class Pet
  attr_reader :name, :age
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :colors
  def initialize(name, age, colors)
    super(name, age)
    @colors = colors
  end

  def to_s
    "My cat #{name} is #{age} years old and has #{colors} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

# My cat Pudding is 7 years old and has black and white fur.
# My cat Butterscotch is 10 years old and has tan and white fur.