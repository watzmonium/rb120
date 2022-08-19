# What is a class?
# What is an object?

class Barbarian
  
  def initialize(name)
    @name = name
  end
  
  def attack
    "attacks"
  end
end

conan = Barbarian.new("Conan")

sonya = Barbarian.new("Sonya")

p conan
p sonya

[conan, sonya].each do |character|
 p character.attack
end

p 'hello world'.is_a?(Integer)
p true.is_a?(TrueClass)
p Array.is_a?(Object)
p conan.is_a?(Kernel)



p "string".class.ancestors

# current class, module, super class, OK BO