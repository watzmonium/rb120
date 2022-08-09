class Shelter
  attr_reader :adopt, :house

  def initialize
    @adopt = {}
  end

  def adopt(owner, pet)
    owner.adopt_pet(pet)
    @adopt[owner.name] ||= owner
  end

  def print_adoptions
    @adopt.each do |name, owner|
      if name == 'The Animal Shelter'
        puts "#{name} has the following unadopted pets:"
      else
        puts "#{name} has adopted the following pets"
      end
      owner.print_pets
      puts
    end
  end

end

class Owner
  attr_accessor :number_of_pets, :pets
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
    @number_of_pets = 0
  end

  def adopt_pet(pet)
    @pets << pet
  end

  def number_of_pets
    pets.size
  end

  def print_pets
    puts pets
  end
end

class Pet
  attr_reader :species, :name

  def initialize(species, name)
    @species = species
    @name = name
  end

  def to_s
    "a #{species} named #{name}"
  end
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')
meepo        = Pet.new('cat', 'Meepo')
banjo        = Pet.new('dog', 'Banjo')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')
the_shelter = Owner.new('The Animal Shelter')

shelter = Shelter.new
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.adopt(the_shelter, meepo)
shelter.adopt(the_shelter, banjo)
shelter.print_adoptions
puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
puts "#{the_shelter.name} has #{the_shelter.number_of_pets} unadopted pets"


# P Hanson has adopted the following pets:
# a cat named Butterscotch
# a cat named Pudding
# a bearded dragon named Darwin

# B Holmes has adopted the following pets:
# a dog named Molly
# a parakeet named Sweetie Pie
# a dog named Kennedy
# a fish named Chester

# P Hanson has 3 adopted pets.
# B Holmes has 4 adopted pets.