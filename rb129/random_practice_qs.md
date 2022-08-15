# What does the following code demonstrate about how instance variables are scoped?

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

In this code, first two new `Person` class people are instantiated on lines 13 and 14, and assigned to local variables `bob` and `joe`. When each Person is instantiated, a new instance of an object of the class type upon which `new` is called is created. In this example, the `Person` class is being used, which takes an argument that is then passed to the `initialize` method  on line 4. That method assigns the value of the parameter, `n`, which points at the string passed when a new object is instantiated, to the instance variable @name. An instance variable is a variable that is scoped within a specific instance of a class, and is by definition tied to that instance itself. However, any instance of that class could theoretically have its own value for that instance variable. That variable is not available outside of the instance and its methods by default, unless some other code exists to access that information like the `get_name` method  on line 8. That method allows access to that variable to other methods or classes, as long as they have the object to which it belongs.

This is an example of encapsulation in objects. Objects store their own information and keep the scope of that information within the instance or class itself unless otherwise explicitly made public to other objects or methods.

----

# what does this output and why? What does this demonstrate about instance variables that differentiates them from local variables?
class Person
  attr_reader :name

  def set_name
    @name = 'Bob'
  end
end

bob = Person.new
p bob.name

This code will output an error because name is not definied for the instance of `Person` assigned to `bob`. This method does not assign a value upon instantiation of this class, and the only way that has been defined in this class to assign a value to the instance vairable `@name` is to call the `set_name` method defined on line 31. Because that method has not been called, and because there is no default intitialization behavior for this class, `@name` has not yet been initialized.

I would argue this isn't really different that a local variable, because a local variable being printed prior to initilization would also throw an error. There is a method here to retreive the variable `@name` from the instance, and sometimes assignment of instance variables differs from local variables, but that isn't necessarily observed here.


# What does this output and why? What does this demonstrate about instance variables
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

In this code segment, the object `teddy` will return `nil` when the `swim` method is called upon it. This is because `swim` only returns the string `"swimming!"` when the instance variable `@can_swim` has a value of true. In order for that to be the case, the `enable_swimming` method must be called to initialize the `@can_swim` instance variable. Because that never happens, the `if @can_swim` is falsey and the function will return `nil` because there's nothing else in it. 

This demonstrates that instance variables have to be initialized to some value before they can be referenced by an object successfully.