state, instance variables, attributes

# what does this output and why? What does this demonstrate about instance variables that differentiates them from local variables?
```ruby
class Person
  attr_reader :name

  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name
```

This code will output `nil` because name is not initialized for the instance of `Person` assigned to `bob`. This method does not assign a value upon instantiation of this class, and the only way that has been defined in this class to assign a value to the instance vairable `@name` is to call the `set_name` method defined on line 31. Because that method has not been called, and because there is no default intitialization behavior for this class, `@name` has not yet been initialized and by default, classes in ruby return `nil` for uninitialized class variables.

This is different than a local variable, because a local variable being printed prior to initilization would throw an error. There is a method here to retreive the variable `@name` from the `attr_reader` on line 4, so the value can be accessed, but it has yet to be initailzed.

# What does this output and why? What does this demonstrate about instance variables
```ruby
module Swimmable
  def enable_swimming
    @can_swim = true
  end
end

class Dog
  include Swimmable

  def swim
    "swimming!" if @can_swim
  end
end

tedd = Dog.new
p teddy.swim
```

In this code segment, the object `teddy` will return `nil` when the `swim` method is called upon it. This is because `swim` only returns the string `"swimming!"` when the instance variable `@can_swim` has a value of true. In order for that to be the case, the `enable_swimming` method must be called to initialize the `@can_swim` instance variable. Because that never happens, the `if @can_swim` is falsey and the function will return `nil` because there's nothing else in it. 

This demonstrates that instance variables have to be initialized to some value before they can be referenced by an object successfully.

# What is output and why? What does this demonstrate about constant scope? What does `self` refer to in each of the 3 methods above?
```ruby
module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES
  end
  
  def sides
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides 
p Square.new.sides 
p Square.new.describe_shape
```

First on line x, the class method `sides` or `self.sides` defined on line y is call on the square class. it returns the value of self::SIDES which, because `Square` inherits from `Quadrilateral` and that class has a defined constant `SIDES` will return a value of `4`.

Then a new `Square` is instantiated and the `sides` method defined on line z is called which returns `self.class::sides` and therefore also returns `4` because self refers to the calling object, and it's class `Square` has the same `SIDES` inherited variable.

Finally, another new `Square` is instantiated and the `describe_shape` method included via mixin of the `Describable` module on line zz is called which will return an error because class constants are not scoped to mixins. In order to access this consant you would need to call something like `self.class::SIDES`

Constants are scoped to the class level, and because the class `Square` inherits from `Quadrilateral`, it inherits that constant. The selves within methods refer to the calling object, but at the definition level or without, refer to the class itself.

# What does the following code demonstrate about how instance variables are scoped?
```ruby
class Person
  def initialize(n)
    @name = n
  end

  def get_name
    @name
  end
end

bob = Person.new('bob')
joe = Person.new('joe')

puts.bob.inspect => <somebullshit>
puts.joe.inspect => <somebullshit>

p bob.get_name
```

In this code, first two new `Person` class people are instantiated on lines 13 and 14, and assigned to local variables `bob` and `joe`. When each Person is instantiated, a new instance of an object of the class type upon which `new` is called is created. In this example, the `Person` class is being used, which takes an argument that is then passed to the `initialize` method  on line 4. That method assigns the value of the parameter, `n`, which points at the string passed when a new object is instantiated, to the instance variable @name. An instance variable is a variable that is scoped within a specific instance of a class, and is by definition tied to that instance itself. However, any instance of that class could theoretically have its own value for that instance variable. That variable is not available outside of the instance and its methods by default, unless some other code exists to access that information like the `get_name` method  on line 8. That method allows access to that variable to other methods or classes, as long as they have the object to which it belongs.

This is an example of encapsulation in objects. Objects store their own information and keep the scope of that information within the instance or class itself unless otherwise explicitly made public to other objects or methods.

----

# What does the code above output, and why? What does this demonstrate about class variables, and why we should avoid using class variables when working with inheritance?

```ruby
class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

p Vehicle.wheels                             

class Motorcycle < Vehicle
  @@wheels = 2
end

p Motorcycle.wheels                           
p Vehicle.wheels                              

class Car < Vehicle; end

p Vehicle.wheels
p Motorcycle.wheels                           
p Car.wheels
```

first on line 8, this code calls the `wheels` class method on the `Vehicle` class, which returns the class variable `@@wheels`, and therefore returns the integer value of `4`. A class method is a method that is called on the `self` of a class and defined in a class as `def self.some_method`. It cannot be called on an instance. Then on line 15 we see the same class method called this time on the `Motorcycle` class, which will return the integer `2` because the `Motorcycle` class has its own defined `@@wheels` class variable which acts to reassign the super-class `Vehicle`'s variable, however it still inherits the `wheels` class method. 

The interesting 'quirk' of this problem is when the `wheels` class method is then again called on the `Vehicle` class, the return value is integer `2` despite the `Vehicle` class having a different class variable value for `@@wheeels`. The value of `@@wheels` never returns to 4, even when the `wheels` class method is called again on other objects. As a result all of the rest of the class `wheels` calls output 2. 

This demonstrates that class variables should not be defined in multiple places, especially when using inheritence. If a class varible needs to be referenced by another class, that class can have its own defined method i.e.

```ruby
def self.wheels
  @@wheels - 2
end
```

# what is output and why? How does this code demonstrate polymorphism?
```ruby
class Animal
  def eat
    puts "i eat"
  end
end

class Fish < Animal
  def eat
    puts "i eat plankton"
  end
end

class Dog < Animal
  def eat
    puts "i eat kibble"
  end
end

def feed_animal(animal)
  animal.eat
end

array_of_animals = [Animal.new, Fish.new, Dog.new]
array_of_animals.each do |animal|
  feed_animal(animal)
end
```

The code above will iterate over the array of animals and pass them to the `feed_animal` method that will call the `eat` method on each of them. as a result, the `Animal` object will call its `eat` method and print `i eat`, the `Fish` object will do the same and print `'i eat plankton'` and the dog will call its own eat method and print `'i eat kibble'`. While the `Fish` and `Dog` classes inherit behaviors from the `Animal` class, each of them has their own separately defined `eat` method, and will look first to their base class for that method before looking at super-classes for the same method. As a result, the class methods will take precedence and those different methods will be called. 

This shows polymorphism because despite inheriting an `eat` method, each object can have a method of the same name called on them with different results. This is an example of 'duck typing' where each object responds similarily to the same method call, so we can treat them as the same class, despite the fact that they are not. While this would work by default on these classes that inherit behvaiors from the `Animal` class, it also works based on how the `eat` methods were implimented in each sub-class.

# What is output on lines 14, 15, and 16, why?

```ruby
class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase!}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name
```

In this code, first a local variables `bob` is initialized and assigned to a new `Person` object with the `'Bob'` argument. The `Person` class has an `initialize` method that by ruby's default behavior, always runs when a new instance of the class is created. Therefore, the value of the instance variable `@name` will be initialized to the string `'Bob'`. In addition, the class has a getter method via the `attr_reader` on line 2 that can be used outside of the class to access the `@name` variable. Finally, this class also has a `to_s` method that will override the default object behavior when `to_s` is called on an object of this class.

As a result, line 14 will reference the getter method and output the value of the `@name` instance variable, as will line 16. Line 15 however is implicitly calling `to_s` on the `Person` object `bob`. `puts` implicitly calls `to_s` on objects, and because the `Person` class has explicitly defined behavior for this, the return value of that `to_s` method will be displayed. In this case `'My name is BOB.'`


# Describe the distinction between modules and classes.

classes in ruby define behavior for objects in ruby including methods, instance and class variables, and their relationships to other classes. Classes can inherit behaviors from super-classes, and can be used to create new objects.

Modules can contain a mix of methods and classes that can be mixed-in to classes to give them new functionality without a direct heritable relationship. For example, a module could have a `Dog` class that could be mixed in with a program to give access to that class, and it could have some methods that give new functionality to any class even if they are not obviously related.

# What is polymorphism and how can we implement polymorphism in Ruby? Provide examples.

Polymorphism is when different objects respond to the same method calls. Polymorphism can be through simple inheritence where sub-classes of a super-class are responding to the exact same method call, or it can be completely different methods with the same name either defined in the class or available via a module. For example, a `Boat` class and a `Car` class might both have methods for `drive` either because they inherit this from a vehicle class, each have their own written method for `drive` or have a module like `Drivable` that provides them with that function. Regardless of how they get it, these different classes respond to the same method call, and that is the essential behavior in polymoprhism


# What is returned/output in the code? Why did it make more sense to use a module as a mixin vs. defining a parent class and using class inheritance?

```ruby
module Walkable
  def walk
    "#{name} #{gait} forward"
  end
end

class Person
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "strolls"
  end
end

class Cat
  include Walkable

  attr_reader :name

  def initialize(name)
    @name = name
  end

  private

  def gait
    "saunters"
  end
end

mike = Person.new("Mike")
p mike.walk

kitty = Cat.new("Kitty")
p kitty.walk
```

In this code, two local variables are initialized: `mike` to a new instance of `Person` and `kitty` to a new instance of `Cat`. Both objects have the `walk` method called on them they they both get from the `Walkable` module mixed in on lines x and y respectively. This method is successfully called on both classes because 1) they each have access to the same `walk` method from the module, and 2) because each class has its own defined `@name` instance variable with a getter method and 3) a `gait` method that is called by that `walk` method. The result is that the `mike` object returns `'mike strolls forward'` and `kitty` returns `'Kitty saunters forward'` because of the individual values for `@name` with which they are instantiated in addition to the predefined `gait` method return values.

This makes more sense to be a mixin rather than a heritable relationship because while you could define some class like `Mammal` through which these two classes share some common relationship, it doesn't necessarily logically make sense that they will have other similar methods. Rather, a mixin module provides access to methods to classes that logically have similar behaviors (like people and cats) without the requisite for a super-class to bind them. 

# What is the method lookup path that Ruby will use as a result of the call to the `fly` method? Explain how we can verify this.

```ruby
module Flight
  def fly; end
end

module Aquatic
  def swim; end
end

module Migratory
  def migrate; end
end

class Animal
end

class Bird < Animal
end

class Penguin < Bird
  include Aquatic
  include Migratory
end

pingu = Penguin.new
pingu.fly
```
There is a general lookup order that objects follow in ruby for method lookup. First, their immediate class, then their modules in order of last included to first included, then any super classes. The lookup path will stop if an object finds a relevant method. This can be verified by using the `ancestors` method on a class.

in this example, the `Penguin` class does not have a `fly` method, and so this object will look in `Penguin` then `Migratory` then `Aquatic`, then `Bird`, then `Animal` and then to the basic ruby classes `Object`, `Kernel` and then `BasicObject` before returning a no method error.

# What does each `self` refer to in the above code snippet?

```ruby
class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new
```
In this code, there are 3 different `self` references. First, the `self` on line 2 that refers to (no idea), then the `self` inside the `self.me` which defines a class method `me` that can be called on the `MeMyselfAndI` to return its name, and finally the `self` referenced in the `myself` method that will return the calling object itself when invoked. Generally `self` refers to the calling object or a way to access its getter and setter methods within other class-level methods.

# What does each `self` refer to in the above code snippet? 

```ruby
module Drivable
  def self.drive
  end
end

class Car
  include Drivable
end

bobs_car = Car.new
bobs_car.drive
```
In this code, a new `Car` object is instantiated and assigned to the local variable `bobs_car`. Then the `drive` method is called on that object, will throw a no method error, because the method `self.drive` on line 2 is a class method. The `self` when referenced as part of a method definition refers to the class itself, and therefore this method can only be called in this example as `Car.drive`

# What module/method could we add to the above code snippet to output the desired output on the last 2 lines, and why?

```ruby
class House
  attr_reader :price

  def initialize(price)
    @price = price
  end

	Addition:
	def < (other)
		price < other.price
	end

	def > (other)
		price > other.price
	end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2 # => Home 1 is cheaper
puts "Home 2 is more expensive" if home2 > home1 # => Home 2 is more
```
In this code 
