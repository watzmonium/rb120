class Fruit
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def consume
    self.eat
  end

  def destroy
    self.crush
  end

  protected

  def eat
    puts "eating #{name}"
  end

  private



  def crush
    puts "crushing #{name}"
  end
end

class Apple < Fruit
  attr_reader :orange
  def initialize(name)
    @orange = Orange.new("yellow orange")
    super(name)
  end

  # public methods in subclass circumvent private/protected!
  def eat
    super
  end

  def crush
    super
  end
  
  def consume
    self.eat # works because same class hierarchy
    self.crush # works because same class hierarchy
    orange.eat # DOES work because in same subclass
    # orange.crush #=> doesn't work because collaborator object even though same subclass
  end
end

class Orange < Fruit
end

class Potato
  attr_reader :berries
  def initialize
    @berries = Fruit.new('potato fruit')
  end

  def prune
    # berries.eat doesnt work because not in same subclass
    berries.consume # works because doesnt directly call private
  end

  def destroy
    # berries.crush doesnt work because not in same subclass
    berries.destroy #works because doesn't directly call private
  end
end

berries = Fruit.new('Berries')
apple = Apple.new('Apple')
orange = Orange.new('Orange')
potato = Potato.new

p berries.name
berries.destroy
apple.consume
apple.destroy
apple.eat
apple.crush
orange.consume
orange.destroy

potato.prune
potato.destroy