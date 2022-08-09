class RPSGame
  GAMES_TO_WIN = 3
  PENTAGRAM = [
    "         ,-  R <,",
    "      ,-'   ^\\  '-,",
    "  <,-'     /  \\    '-,_",
    "L  _______/____\\________> P",
    " ^.      /      \\     ,-'^",
    "|    -, /        \\ ,-'   |",
    "|      /-.      ,-\\      |",
    "|     /   '-,.-'   \\     |",
    "|    /    ,-''-.    \\    |",
    "|   /  ,-'      '-.  \\   |",
    "V / <'            '-. V  |",
    "S -------------------> C"]
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = get_cpu_players
    Move.valid_moves << [Rock.new, Paper.new, Scissors.new, Lizard.new, Spock.new]
    Move.valid_moves.flatten!
  end

  def play
    display_message_welcome
    display_instructions
    set_names
    loop do
      player_turns
      display_moves
      compute_winner
      break if display_set_winner
    end
  end

  def play_again?
    yes_or_no?("Would you like to play again?(y/n)")
  end

  def display_goodbye_message
    puts "Thanks for playing!"
  end

  def display_move_history
    return unless yes_or_no?("Do you want to see move history?")
    1.upto(human.move_history.size) do |round|
      puts "Round #{round}:"
      puts "#{human.name} played #{human.move_history[round - 1]}"
      puts "#{computer.name} played #{computer.move_history[round - 1]}"
      puts
    end
  end

  private

  def get_cpu_players
    [Cavemanspock.new, Lizguy.new].sample
  end

  def display_instructions
    return unless yes_or_no?("Would you like instructions on how to play?")
    puts "This game is like rock paper scissors, except with lizards and spock"
    puts "Please reference the diagram below using the 'arrow lines' to determine what beats what."
    puts PENTAGRAM
    puts "Press any key to continue"
    gets
  end

  def yes_or_no?(message)
    puts message
    answer = gets.chomp
    system 'clear'
    return false unless answer.start_with?('y')
    true
  end

  def display_message_welcome
    puts "Welcome to Rock Paper Scissors Lizard Spock!"
    puts "First to #{GAMES_TO_WIN} wins!"
  end

  def set_names
    human.set_name
    computer.set_name
  end

  def player_turns
    human.choose
    computer.choose
  end

  def display_moves
    system 'clear'
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def compute_winner
    if human.move > computer.move
      display_winner(human)
    elsif computer.move > human.move
      display_winner(computer)
    else
      puts "It's a tie!"
      show_standings
    end
  end

  def display_winner(winner)
    puts "#{winner.name} won!"
    winner.score += 1
    show_standings
  end

  def show_standings(start_word='Standings:')
    puts start_word
    print_scores
  end

  def display_set_winner
    if human.score == GAMES_TO_WIN
      final_screen(human.name)
      return true
    elsif computer.score == GAMES_TO_WIN
      final_screen(computer.name)
      return true
    end
    false
  end

  def final_screen(winner)
    system 'clear'
    display_moves
    print_final_score(winner)
  end

  def print_final_score(winner)
    show_standings("Final score:")
    puts "#{winner} wins the match!"
    puts "Game Over YEAH!"
  end

  def print_scores
    puts "#{human.name}: #{human.score} | #{computer.name}: #{computer.score}"
  end
end

class Player
  attr_accessor :move, :name, :score, :move_history

  def initialize
    @score = 0
    @move_history = []
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      system 'clear'
      puts "Please enter your name"
      n = gets.chomp
      break unless n.empty?
    end
    self.name = n
  end

  def choose
    mv = nil
    loop do
      puts "Please choose: rock, paper, scissors, lizard, or spock:"
      mv = gets.chomp.downcase
      break if Move::CHOICES.keys.include?(mv)
      system 'clear'
      puts "please enter a valid choice."
    end
    temp_move = Move.valid_moves.select { |obj| obj.value == mv }
    self.move = temp_move[0]
    self.move_history << move.value
  end
end

class Computer < Player

  def choose
    self.move = Move.valid_moves.sample
    self.move_history << move.value
  end
end

class Lizguy < Computer
  def set_name
    self.name = 'Lizzguy~'
  end

  def choose
    self.move = Lizard.new
    self.move_history << move.value
  end
end

class Cavemanspock < Computer
  def set_name
    self.name = 'UNGA BUNGA'
  end

  def choose
    a = rand(2)
    if a == 1
      self.move = Rock.new
    else
      self.move = Spock.new
    end
    self.move_history << move.value
  end
end

class Move
  CHOICES = { 'rock' => ['scissors', 'lizard'], 
              'paper' => ['rock', 'spock'], 'scissors' => ['paper', 'lizard'],
              'lizard' => ['paper', 'spock'], 'spock' => ['rock', 'scissors'] }

  @@valid_moves = []
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def >(other)
    CHOICES[value].include?(other.value)
  end

  def <(other)
    !CHOICES[value].include?(other.value)
  end

  def self.valid_moves
    @@valid_moves
  end

  def to_s
    value
  end
end

class Rock < Move
  def initialize
    super('rock')
  end
end

class Paper < Move
  def initialize
    super('paper')
  end
end

class Scissors < Move
  def initialize
    super('scissors')
  end
end

class Lizard < Move
  def initialize
    super('lizard')
  end
end

class Spock < Move
  def initialize
    super('spock')
  end
end

loop do
  game = RPSGame.new
  game.play
  game.display_move_history
  unless game.play_again?
    game.display_goodbye_message
    break
  end
end
