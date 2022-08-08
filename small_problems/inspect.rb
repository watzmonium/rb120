# puts "Hello".class
# puts 5.class
# puts [1, 2, 3].class

module Walkable
  def walk
    puts "let's go for a walk!"
  end
  
end

class Cat
  COLOR = 'purple'
  @@cat_num = 0
  attr_accessor :name
  def initialize(name)
    @name = name
    @@cat_num += 1
  end

  def self.total
    @@cat_num
  end

  include Walkable

  def self.generic_greeting
    puts "Hello, i am cat"
  end

  def personal_greeting
    puts "hello i am #{self.name}"
  end

  def rename(name)
    self.name = name
  end

  def identify
    self
  end

  def greet
    puts "Hello my name is #{self.name} and i am a #{COLOR} cat!"
  end

  def to_s
    "I'm #{self.name}"
  end
end

kitty = Cat.new("soph")
poop = Cat.new("gorp")
kitty.rename('luna')
kitty.greet
# kitty.walk
# p kitty.identify
kitty.personal_greeting
Cat.generic_greeting
p Cat.total
puts kitty