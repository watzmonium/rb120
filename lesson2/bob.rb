# class Person
#   attr_accessor :name, :first_name, :last_name

#   def initialize(n, last='')
#     @first_name = n
#     @last_name = last
#     @name = @first_name + @last_name
#   end

#   def last_name=(last)
#     @last_name = last
#     @name = @first_name + ' ' + @last_name
#   end
# end
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private
  
  def parse_full_name(full_name)
    parts = full_name.split(' ')
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.name == rob.name

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'

# bob.name = "John Adams"
# p bob.first_name            # => 'John'
# p bob.last_name             # => 'Adams'