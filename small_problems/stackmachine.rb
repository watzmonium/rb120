class EmptyStack < StandardError
  attr_reader :message

  def initialize
    @message = "Empty Stack!"
  end
end

class InvalidToken < StandardError
  attr_reader :message

  def initialize(token)
    @message = "Invalid Token: #{token}"
  end
end

class Minilang
  def initialize(inputs)
    @commands = inputs.split(' ')
    @register = 0
    @stack = []
  end

  def eval
    commands.each do |command|
      if integer?(command)
        self.register = command.to_i
      else
        register_cases(command)
      end
    end
  end

  private 

  def register_cases(command)
    case command
    when 'PUSH' then stack << register
    when 'ADD' then self.register += stack.pop 
    when 'SUB' then self.register -= stack.pop
    when 'MULT' then self.register *= stack.pop
    when 'DIV' then self.register /= stack.pop unless stack.last.zero?
    when 'MOD' then self.register = register % stack.pop
    when 'POP' then validate_stack
    when 'PRINT' then puts register
    else raise InvalidToken.new(command)
    end
  end

  def validate_stack
    if stack.empty?
      raise EmptyStack
    else
      self.register = stack.pop
    end
  end

  def integer?(string)
    string.to_i.to_s == string
  end

  attr_accessor :commands, :register, :stack
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

#Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

# Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)