class Person
  attr_reader :friends

  def initialize
    @friends = []
  end

  def <<(friend)
    @friends << friend.name
  end

  def []=(location, object)
    @friends[location] = object.name
  end

  def [](location)
    @friends[location]
  end
end

class Friend
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

tom = Person.new
john = Friend.new('John')
amber = Friend.new('Amber')

tom << amber
tom[1] = john
p tom[0]      # => Amber
p tom.friends # => ["Amber", "John"]
