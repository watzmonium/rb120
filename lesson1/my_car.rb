class MyCar
  attr_accessor :color, :speed
  attr_reader :year

  def initialize(y, c, m)
    @year = y
    @color = c
    @model = m
    @speed = 0
  end

  def speed_up(speed)
    self.speed = speed
  end

  def brake(s)
    self.speed -= s
  end

  def turn_off
    self.speed = 0
  end

  def spray_paint(c)
    self.color = c
  end
end

civic = MyCar.new('2003', 'Black', 'Civic')

civic.spray_paint('blue')
puts civic.color

# puts civic.speed
# civic.speed_up(60)
# puts civic.speed
# civic.brake(40)
# puts civic.speed
# civic.turn_off
# puts civic.speed

# puts civic.color
# civic.color = 'Blue'
# puts civic.color
# puts civic.year
# civic.year = '2001'