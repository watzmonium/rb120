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