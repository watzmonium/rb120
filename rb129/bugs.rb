module Walk
  STR = "Walking"
end

module Run
  def str
    Bugs::STR
  end
end

module Jump
  STR = "Jumping"
end

class Bunny
  include Jump
  include Walk
  include Run
end

class Bugs < Bunny
  STR = "Running"

  
end

p Bugs.ancestors
p Bugs::STR
bugs = Bugs.new
p bugs.str