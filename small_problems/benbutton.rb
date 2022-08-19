# Perform the implementations for each method to output as shown:

class BenjaminButton
  attr_reader :appearance_age, :actual_age

  def initialize
    @actual_age = 0
    @appearance_age = 100
  end
  
  def get_older
    self.actual_age += 1
    self.appearance_age -= 1
  end

  def actual_age=(age)
    @actual_age = age.to_i
  end
  
  def look_younger
  end
  
  def die
    self.actual_age = 100
    self.appearance_age = 0
  end
  
  private
  attr_writer :appearance_age
end

benjamin = BenjaminButton.new
p benjamin.actual_age # => 0
p benjamin.appearance_age # => 100

benjamin.actual_age = '1'

benjamin.get_older
p benjamin.actual_age # => 2
p benjamin.appearance_age # => 99

benjamin.die
p benjamin.actual_age # => 100
p benjamin.appearance_age # => 0