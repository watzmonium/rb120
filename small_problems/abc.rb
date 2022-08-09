
class Transform
  attr_reader :uppercase
  def initialize(str)
    @uppercase = str.upcase
  end

  def self.lowercase(str)
    str.downcase
  end
end


my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# ABC
# xyz