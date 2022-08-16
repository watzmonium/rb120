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

# This class represents the game that coordinates player and cpu actions
# in addition to initializing the deck
# rubocop:disable Metrics/ClassLength
class TWENTYONEGame
  include ValidateStr
  attr_accessor :user, :cpu
  attr_reader :over, :deck, :winner

  def initialize
    @deck = Deck.new
    @cpu = Computer.new
  end

  def play
    @over = false
    game_intro
    loop do
      deal_starting_cards
      player_turn
      computer_turn unless over
      display_results
      break unless play_again?

      reset
    end
  end

  def game_intro
    display_message('Welcome to 21!')
    display_message('Please enter your name: ')
    name = gets.chomp
    @user = Human.new(name)
    display_message('Would you like instructions on how to play? (Y/N)')
    choice = validate_input(%w[Y N])
    instructions if choice.upcase == 'Y'
  end

  def instructions
    clear
    puts 'Instructions:'
    puts 'The goal of the game is to accumulate cards whose sums come as close'
    puts 'to 21 as possible without going over. All number cards(2-10) have'
    puts 'their face value. Face cards (J, Q, K) are each worth 10, and Aces are worth 1 or 11.'
    puts 'Press any key to continue'
    gets
  end

  def add_card(player)
    player.hand << deck.deal_card!
    player.update_total
  end

  def deal_starting_cards
    2.times do
      add_card(user)
      add_card(cpu)
    end
  end

  def clear
    system 'clear'
  end

  def player_turn
    loop do
      clear
      display_game(true, 'shows')
      break unless user.hit_or_stay

      add_card(user)
      if user.busted?
        @over = true
        break
      end
    end
  end

  def computer_turn
    loop do
      clear
      display_game
      sleep(1.2)
      break unless cpu.hit_or_stay

      add_card(cpu)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def display_game(hidden = false, has = 'has')
    display_cards(cpu, hidden)
    display_cards(user)
    display_message("#{user.name} has #{user.total}.")
    print "Dealer #{cpu.name} #{has} "
    puts hidden ? cpu.secret_total : cpu.total
  end

  # rubocop:disable Metrics/MethodLength
  def display_cards(player, hidden = false)
    cards = player.printable_hand
    card_num = cards.size
    cards[0] = '??' if hidden
    card_num.times { print ' ___  ' }
    puts ''
    card_num.times { |num| print '|' + cards[num][0] + '  | ' }
    puts ''
    card_num.times { |num| print '| ' + cards[num][1] + ' | ' }
    puts ''
    card_num.times { |num| print '|__' + cards[num][0] + '| ' }
    puts "\n\n"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def display_results
    clear
    display_game
    determine_winner
    display_message("Game over! #{winner.name} wins!")
    puts 'You busted! Be careful!' if user.busted? && winner == cpu
  end

  def determine_winner
    if user.busted?
      @winner = cpu
    elsif cpu.busted?
      @winner = user
    else
      @winner = user.total > cpu.total ? user : cpu
    end
  end

  def play_again?
    display_message('Would you like to play again? (Y/N)')
    choice = validate_input(%w[Y N])
    choice.upcase == 'Y'
  end

  def reset
    @deck = Deck.new
    user.empty_hand
    cpu.empty_hand
  end
end
# rubocop:enable Metrics/ClassLength

# This class has holds a deck of 52 cards, 13 from each suit and can deal them destructively
class Deck
  SUITS = ['♥', '♦', '♠', '♣'].freeze
  VALUES = { 'A' => 11, '2' => 2, '3' => 3, '4' => 4, '5' => 5,
             '6' => 6, '7' => 7, '8' => 8, '9' => 9, 'T' => 10,
             'J' => 10, 'Q' => 10, 'K' => 10 }.freeze

  attr_reader :deck

  def initialize
    @deck = create_deck
  end

  def deal_card!
    card = deck.sample
    deck.delete(card)
    card
  end

  private

  def create_deck
    SUITS.each_with_object([]) do |suit, deck_of_cards|
      VALUES.each do |face, value|
        deck_of_cards << Card.new(suit, face, value)
      end
    end
  end
end

# Each card has values for display and math purposes
class Card
  attr_reader :suit, :face, :value
  def initialize(suit, face, value)
    @suit = suit
    @face = face
    @value = value
  end
end

# Designed to basically store an array of cards. Maybe shouldnt be a class?
class Hand
  attr_accessor :cards
  def initialize
    @cards = []
  end

  def [](card_num)
    cards[card_num].value
  end

  def <<(card)
    cards.push(card)
  end
end

# Generic player methods and attributes
class Player
  BUST_NUM = 21
  attr_accessor :hand, :total

  def initialize
    @hand = Hand.new
    @total = 0
  end

  def empty_hand
    @hand = Hand.new
  end

  def printable_hand
    hand.cards.each_with_object([]) do |card, ary|
      ary << "#{card.face}#{card.suit}"
    end
  end

  def hit(card)
    hand << card
  end

  def busted?
    total > BUST_NUM
  end

  def update_total
    tot = 0
    hand.cards.each { |card| tot += card.value }
    self.total = tot
    if busted?
      aces = hand.cards.select { |card| card.face == 'A' }.count
      while aces.positive?
        self.total -= 10
        aces -= 1
      end
    end
    self.total
  end
end

# has a few human specific actions
class Human < Player
  include ValidateStr
  attr_reader :name

  def initialize(name)
    @name = name
    super()
  end

  def hit_or_stay
    display_message('Would you like to hit or stay? (H/S)')
    choice = validate_input(%w[H S])
    choice.upcase == 'H'
  end
end

# Has a few CPU specific actions including hiding its total when needed
class Computer < Player
  CPU_NAMES = ['Frederic', 'Gustav', 'Lizzy~', 'Caveman Spock'].freeze
  STAY_NUM = 17
  attr_reader :name
  def initialize
    @name = CPU_NAMES.sample
    super()
  end

  def hit_or_stay
    return false if busted?

    total < STAY_NUM
  end

  def secret_total
    total - hand.cards[0].value
  end
end

game = TWENTYONEGame.new
game.play
puts 'Thanks for playing!'
