class GoodDog
  attr_writer :name
  # attr_accessor :name, :height, :weight
  # attr_reader :name << this would allow us to not alter the instance variable
  # attr_writer :name << only lets you write but not access
  def initialize(name)
    @name = name
  end

  # all of this setter and getting methods are pointless because of line 2.
  def name # << this is the method we call call in speak
    @name + 'poop'
  end

  # # note that setter methods return the argument value no matter what heppens in them
  # def name=(n)
  #   @name = n
  # end

  def speak
    "#{name} says AWOOOOOO"
  end
end

gorp = GoodDog.new('Gorp')
puts gorp.name
gorp.name = 'GORP!'
puts gorp.speak