class GoodDog
  attr_accessor :height, :weight, :name
  @@number_of_dogs = 0

  def initialize(h, w, n)
    # so here we're calling self instead of @height, @weight, @name
    # because these self messages call the setter methods and are NOT directly
    # altering the varaible. This is important if the setter/getter methods have unusual
    # or custom functionality defined for that object. It's styliscally good.
    @@number_of_dogs += 1
    self.height = h
    self.weight = w
    self.name = n
  end

  def self.what_am_i
    "I'm a GoodDog class!"
  end

  def self.total_number_of_dogs
    @@number_of_dogs
  end

  def speak
    "#{name} says WOOF"
  end

  def change_info(h, w, n)
    self.height = h
    self.weight = w
    self.name = n
  end

  def info
    "#{name} weighs #{weight} and is #{height} tall"
  end

  def to_s
    "This dog's name is #{name}"
  end
end

poop = GoodDog.new("3'1", "455 lbs", "Bork")
p GoodDog.what_am_i
puts poop.speak
puts poop.info
poop.change_info("2'0", "1 lb", "Gorp")
puts poop.info

puts GoodDog.total_number_of_dogs

puts "hello #{poop}"