# frozen_string_literal: true

# This module allows objects to validate strings input from the user
# or properly display choices. Both the board and game use these methods
module ValidateStr
  def validate_input(choices, board = false)
    loop do
      input = gets.chomp
      return input if choices.include?(input.upcase)

      system 'clear'
      display_board if board
      puts "That's not a valid choice."
      puts 'Please choose from the following choices: '
      puts join_or(choices)
    end
  end

  def join_or(choices)
    return choices[0] if choices.size == 1

    sentence = choices[0..-2].join(', ')
    "#{sentence} or #{choices[-1]}"
  end

  def display_message(message = '')
    puts message
  end
end

# This class plays the game by interacting with other classes
# without letting them 'speak' to each other.
class TTTGame
  attr_reader :board, :user, :cpu, :winner
  include ValidateStr

  def initialize
    @board = Board.new
    @cpu = Computer.new
  end

  def play
    display_message('Welcome to TTT!')
    @user = Human.new
    cpu.easy_mode?
    loop do
      turn_person = go_first?
      game_loop(turn_person)
      display_result
      break unless play_again?

      reset
    end
  end

  private

  def go_first?
    display_message('Would you like to go first, second, or random?')
    display_message("Enter 'F' for first, 'S' for second, or 'R' for random.")
    choice = validate_input(%w[F S R])
    return assign_first_player(user) if choice.downcase == 'f'

    return assign_first_player(cpu) if choice.downcase == 's'

    assign_first_player([user, cpu].sample)
  end

  def assign_first_player(player)
    user.user_marker = player == user ? 'X' : 'O'
    cpu.user_marker = player == user ? 'O' : 'X'
    player
  end

  def clear
    system 'clear'
  end

  def game_loop(turn_person)
    loop do
      game_display
      turn_person.take_turn(board)
      break if someone_won? || board_full?

      turn_person = switch_user(turn_person)
    end
  end

  def game_display
    clear
    puts "#{user.name} is #{user.user_marker}. #{cpu.name} is #{cpu.user_marker}."
    board.display_board
  end

  def switch_user(person)
    person == user ? cpu : user
  end

  def someone_won?
    board.lines.each do |_, sets|
      sets.each do |set|
        return true if victor(set)
      end
    end
    false
  end

  def victor(set)
    if set.all? { |box| board[box] == user.user_marker }
      @winner = user
      true
    elsif set.all? { |box| board[box] == cpu.user_marker }
      @winner = cpu
      true
    end
  end

  def board_full?
    board.free_squares.empty?
  end

  def display_result
    game_display
    if winner.nil?
      display_message("Cat's game!")
    else
      display_message("#{winner.name} wins!")
      winner.games_won += 1
    end
    display_standings
  end

  def display_standings
    display_message('Current standings: ')
    display_message("#{user.name} : #{user.games_won} | #{cpu.name} : #{cpu.games_won}")
  end

  def play_again?
    display_message('Would you like to play again? (Y/N)')
    choice = validate_input(%(Y N))
    clear
    choice.upcase == 'Y'
  end

  def reset
    @board = Board.new
    @winner = nil
  end
end

# This class keeps all board information to be read by the game class
class Board
  SQUARE_ORDER = 3
  INITIAL_MARKER = ' '
  SPACE_LINE = '     |     |'
  HORIZ_LINE = '-----+-----+-----'
  include ValidateStr
  attr_accessor :squares
  attr_reader :lines

  def initialize
    @squares = {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
    @lines = { rows: find_rows, columns: find_columns, diagonals: find_diagonals }
  end

  def display_board
    puts ''
    print_line(1, 2, 3)
    puts HORIZ_LINE
    print_line(4, 5, 6)
    puts HORIZ_LINE
    print_line(7, 8, 9)
    puts ''
  end

  def pick_squares
    puts 'Please pick a square: '
    choices = free_squares.map(&:to_s)
    puts join_or(choices)
    validate_input(choices, true)
  end

  def free_squares
    squares.select { |_, mark| mark.marker == INITIAL_MARKER }.keys
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def [](num)
    @squares[num].marker
  end

  private

  def print_line(first, second, third)
    puts SPACE_LINE
    puts "  #{squares[first]}  |  #{squares[second]}  |  #{squares[third]}"
    puts SPACE_LINE
  end

  def get_square(number)
    @squares[number]
  end

  def find_rows
    1.step(by: SQUARE_ORDER).take(SQUARE_ORDER).each_with_object([]) do |start, ary|
      ary << start.step.take(SQUARE_ORDER)
    end
  end

  def find_columns
    (1..SQUARE_ORDER).each_with_object([]) do |start, ary|
      ary << start.step(by: SQUARE_ORDER).take(SQUARE_ORDER)
    end
  end

  # rubocop:disable Style/ConditionalAssignment
  def find_diagonals
    [1, SQUARE_ORDER].each_with_object([]) do |start, ary|
      if start == 1
        ary << start.step(by: (SQUARE_ORDER + 1)).take(SQUARE_ORDER)
      else
        ary << SQUARE_ORDER.step(by: (SQUARE_ORDER - 1)).take(SQUARE_ORDER)
      end
    end
  end
  # rubocop:enable Style/ConditionalAssignment
end

# These act as the objects in the board squares
class Square
  attr_accessor :marker
  def initialize(marker)
    @marker = marker
  end

  def to_s
    marker
  end
end

# generic player class for inheritance of common variables
class Player
  attr_accessor :user_marker, :games_won
  attr_reader :name
  def initialize
    @games_won = 0
  end
end

# allows tracking of games won and human-specific methods
class Human < Player
  def initialize
    set_user_name
    super
  end

  def take_turn(board)
    board[board.pick_squares.to_i] = user_marker
  end

  private

  def set_user_name
    puts 'Please enter your name: '
    @name = gets.chomp
    system 'clear'
    puts "Welcome, #{name}"
  end
end

# allows tracking of computer methods and games won
class Computer < Player
  CPU_NAMES = ['Frederic', 'Gustav', 'Lizzy~', 'Caveman Spock'].freeze
  def initialize
    @name = CPU_NAMES.sample
    @easy_mode = false
    super
  end

  def easy_mode?
    puts 'Do you want to play on easy mode? (Y/N)'
    choice = gets.chomp
    @easy_mode = true if choice.upcase == 'Y'
  end

  def take_turn(board)
    human_marker = user_marker == 'X' ? 'O' : 'X'
    board[best_move(board, human_marker)] = user_marker
  end

  private

  attr_reader :easy_mode

  def best_move(board, human_marker)
    if easy_mode
      chance = rand(3)
      return board.free_squares.sample if chance == 1
    end

    winning_move = find_move(board, user_marker)
    return winning_move if winning_move

    save_move = find_move(board, human_marker)
    return save_move if save_move

    return 5 if board[5] == ' '

    good_choice = board.free_squares.select(&:odd?).sample
    return good_choice unless good_choice.nil?

    board.free_squares.sample
  end

  def find_move(board, marker)
    board.lines.each do |_, sets|
      sets.each do |set|
        next unless set.count { |box| board[box] == marker } == 2

        move = set.select { |box| board[box] == ' ' }
        next if move.empty?

        return move.first
      end
    end
    nil
  end
end

game = TTTGame.new
game.play
puts 'Thanks for playing!'
