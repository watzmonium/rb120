#yay i get to do something

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet('hello')
  end
end

class Goodbye < Greeting
  def goodbye
    greet('goodbye')
  end
end