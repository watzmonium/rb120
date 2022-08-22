class GuessingGame
  def initialize(low = 1, high = 100)
    @low = low
    @high = high
    @number_of_guesses = Math.log2(high - low).to_i + 1
    @number = rand(low..high)
    @win = false
  end

  def play
    while number_of_guesses > 0
      puts "You have #{number_of_guesses} guesses remaining."
      guess = validate_guess
      check_guess(guess)
      puts
      self.number_of_guesses -= 1
      break if win || number_of_guesses == 0
    end

    puts "You won!" if win
    puts "You have no more guesses! You lost!" unless win
  end


  private

  attr_accessor :number_of_guesses, :win
  attr_reader :number, :low, :high

  def validate_guess
    loop do
      print "Enter a number between #{low} and #{high}: "
      guess = gets.chomp.to_i
      return guess if (low..high) === guess
      puts "Invalid guess."
    end
  end

  def check_guess(guess)
    if guess > number
      puts "Your guess is too high"
    elsif guess < number
      puts "Your guess is too low"
    else
      puts "That's the number!"
      self.win = true
    end
  end
end

game = GuessingGame.new(501, 1500)
game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 104
# Invalid guess. Enter a number between 1 and 100: 50
# Your guess is too low.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 75
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 85
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 0
# Invalid guess. Enter a number between 1 and 100: 80

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 81
# That's the number!

# You won!

# game.play

# You have 7 guesses remaining.
# Enter a number between 1 and 100: 50
# Your guess is too high.

# You have 6 guesses remaining.
# Enter a number between 1 and 100: 25
# Your guess is too low.

# You have 5 guesses remaining.
# Enter a number between 1 and 100: 37
# Your guess is too high.

# You have 4 guesses remaining.
# Enter a number between 1 and 100: 31
# Your guess is too low.

# You have 3 guesses remaining.
# Enter a number between 1 and 100: 34
# Your guess is too high.

# You have 2 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have 1 guesses remaining.
# Enter a number between 1 and 100: 32
# Your guess is too low.

# You have no more guesses. You lost!