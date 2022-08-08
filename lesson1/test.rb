class MyClass
  attr_accessor :word

  def initialize(name)
    @word = name
  end

  def word
    @word
    'hello'
  end
end

c = MyClass.new('bob')
p c.word = 'hi'
c.word
p c.inspect