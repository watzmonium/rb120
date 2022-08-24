# Notes for OOP Book

Why OOP? You can create 'containers' that make data easier to manage since objects don't change the program at large

# Encapsulation 

  hiding pieces of functionality and making it unavailable to the rest of the code base. 
  it protects data from being altered without specific intent
  # why is this so important? #

# Polymorphism
  
  the ability for different types of data to respond to a common interface
  it lets objects of different types respond to the same method invocation.

# Inheritance

  a class inherits the behavior of another SUPERCLASS
  allows you to define SUPERCLASSES with a lot of reusability and SUBCLASSES with more fine-tuned behaviors

# Modules

  are these libaries?
  use 'include'
  called a `mixin`

# Objects

  everything that has a value is an object
  methods, blocks, and variables are not objects
  collaborative objects associative relationship  

# Classes

  delcaring a class
    `Class` CamelCase
    `end`
  ruby filenames are in snake_case and reflect the class name
    i.e. camel_case.rb
  creating a new object is called `instantiation`

# Instance variables

  `@varname`
  this type of variable exists as long as the object instance exists
  ties data to the object
  it doesn't become free once the object is instatiated like a method variable would
  is available to use in methods for the class

# instance methods vs class methods

  `class methods` can be called without having to instantiate any object
  # def self.method_name #

# Class variables

  denoted useing `@@var_name`


# Namespacing

  organizing similar classses under a module
  `module Mammal`
    `class Dog`
    end
    `class cat`
    end
  end

  dog = Mammal::Dog.new

# Collaborator Objects

  objects stored inside other objects

# How to write OOP programs

  1) Write a description of the problem and extract major nouns and verbs.

  2) Make an initial guess at organizing the verbs and nouns into methods and classes/modules, then do a  spike to explore the problem with temporary code.

  3) When you have a better idea of the problem, model your thoughts into CRC cards.

# CRC Cards

  CLASS NAME
  ------------------|---------------
  Responsibilities  |  Collaborators
                    |
                    |
                    |

# Encapsulation:
       * Refers to bundling data with methods that can operate on that data within a class.
       * It’s the idea of hiding data within  a class, preventing anything outside that class directly interacting with it.
       * Keeps the programmer in control of access to data.
       * Related to method access control


# Abstraction:
       * Refers to the idea to only showing essential details and keeping everything else hidden.
       * The classes you create should act like your car. Users of your classes should not worry 
       about the inner details of those classes.
       * This is very important when working on your program incrementally.
       
# Inheritance:
       * Is the principle that allows classes to derive from other classes.
       * Related to method access control

# Polymorphism:
       * Describes methods that are able to take on many forms.
       * Allows methods to take on many different forms.
       * Be sure that you are calling the correct form of the method.
       * There are two types of polymorphism: 
        	** Dynamic polymorphism: 
            - Occurs during the runtime of the program.
            - Describes when a method signature is in both subclass and a superclass.
        		- The methods share the same name but have different implementation.
            - The implementation of the subclass that the object is an instance of 
              overrides that of the superclass.
          ** Static polymorphism: *** DOESNT EXIST IN RUBY ***
            -  Occurs during compile-time rather than during runtime.
            -  Refers to when multiply methods with the same name but different arguments
                are defined in the same class.
            -  The parameters are different type or taken in different order.
            -  This is known as method overloading.

# MAC

  # PRIVATE
  YOU CANNOT directly call a private class OUTSIDE of the class/subclass EVER
  You CAN call a private method from within the class itself, or a subclass
  HOWEVER, even a collaborator object of the same type within a class cannot access private methods

  # PROTECTED
  YOU CANNOT directly call a protected class OUTSIDE of the class/subclass EVER
  BUT you can access these methods from objects of the same class/subclass within other classes of the same type
  I.E if an object acts as a collaborator, that object can have access to protected methods
  you CAN call these with an explicit receiver (i.e. self.protected_method)
  BUT you cannot call it on an object
