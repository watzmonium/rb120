# Problem taken from tinyurl.com/mr42tf4t, creator: Raul Romero

class Human 
  attr_reader :name, :color

  def initialize(name = "Dylan")
    @name = name
  end

  def self.hair_color(a = '', color = "blonde")
    "Hi, my name is Dylan and I have #{color} hair."
  end

  def hair_color(color = "blonde")
    "Hi, my name is #{name} and I have #{color} hair."
  end

end

puts Human.new("Jo").hair_color("blonde")  
# Should output "Hi, my name is Jo and I have blonde hair."

puts Human.hair_color("")              
# Should "Hi, my name is Dylan and I have blonde hair."