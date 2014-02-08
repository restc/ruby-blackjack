# A simple game of blackjack
# Built by Raleigh St. Clair
# Twitter: raleighesc  Github: restc

# This is my first working app,
# please excuse the hackiness.


####################
###     CARD     ###

class Card
  attr_reader :number, :suit

  def initialize(suit, number)
    if !VALID_SUITS.include? suit
      raise DeckErrors.invalid_suit
    elsif !VALID_NUMBERS.include? number
      raise DeckErrors.invalid_number
    else
      @suit, @number = suit, number
    end
  end

  VALID_NUMBERS = (2..14).to_a
  VALID_SUITS = ["Hearts", "Spades", "Diamonds", "Clubs"] 

  def print
    case self.number
    when 11
      puts "Jack of #{self.suit}"
    when 12
      puts "Queen of #{self.suit}"
    when 13
      puts "King of #{self.suit}"
    when 14
      puts "Ace of #{self.suit}"
    else
      puts "#{self.number} of #{self.suit}"
    end
  end

  def print_number
    case self.number
    when 11
      10
    when 12
      10
    when 13
      10
    when 14
      11
    else
      self.number
    end
  end

end #Class Card
#       CARD       #
####################


####################
###     DECK     ###

class Deck
  # This will gather the cards needed to create a full deck
  
  include Enumerable
  # This allows enumerable methods to be used on Arrays

  attr_reader :deck


  # This works and returns a deck object, composed of an array of cards.
  # To access array, call `.deck` on new Deck object, i.e.:

  # => # full_deck = Deck.new
  # => # deck = full_deck.deck => returns Array

  def initialize
  #   Could add options so that game can be created with different amounts of cards depending upon the game being created

    deck = Array.new

    Card::VALID_SUITS.each do |vs|
      Card::VALID_NUMBERS.each do |vn|
        deck.push Blackjack::Card.new(vs, vn)
      end
    end
    @deck = deck.shuffle
  end

  def self.shuffle
    random_gen = Random.new
    shuffled = Array.new
    52.times do 
      shuffled << random_gen.rand(52) 
    end
    return shuffled
  end

end # End Deck class
#       DECK       #
####################


####################
###    PURSE     ###

class Purse
  attr_reader :value

  def initialize(value=100)
    @value = value
  end

end

#      PURSE       #
####################



######################
###     PLAYER     ###
 
class Player
  attr_reader :name
  attr_accessor :purse, :hand, :score

  attr_accessor :busted
  attr_accessor :stand

  def initialize name
    @name = name
    @hand = Hand.new
    @purse = Purse.new
    @busted, @stand = false, false
  end

  def busted?
    @busted = false
  end

  def stand?
    @stand = false
  end

  def score
    self.hand.points
  end

end # Player class
###     PLAYER     ###
######################




######################
###      HAND      ###

class Hand

  attr_reader :busted
  attr_reader :cards

  def initialize
    @cards = Array.new
  end

  def num_cards
    self.cards.length
  end

  def points
    unless self.class != Hand
      self.cards.map {|card| 
        case card.number
        when 11
          10
        when 12
          10
        when 13
          10
        when 14
          11
        else
          card.number
        end
        }.inject(:+)
    end
  end

  def print_score
    print "#{self.name} :  #{self.hand.score} points with #{self.hand.cards_in_hand} cards."
  end

  def aces?
    aces = 0
    self.cards.map {|card| 
      if card.number == 14 
        aces += 1
      end
    }
    return aces
  end

  def cards_in_hand
    self.cards.length
  end

  def self.busted?
    unless score > 21
      @busted = false
    end
  end

  def show_cards
    self.cards.each do |card|
      case card.number
      when 11
        puts "Jack of #{card.suit}"
      when 12
        puts "Queen of #{card.suit}"
      when 13
        puts "King of #{card.suit}"
      when 14
        puts "Ace of #{card.suit}"
      else
        puts "#{card.number} of #{card.suit}"
      end
    end
    nil
  end

end

###      HAND      ###
######################



##############################
###        BLACKJACK       ###


class Blackjack

  attr_reader :deck
  attr_reader :players, :dealer
  attr_reader :winner

  def initialize(name=nil)
    Blackjack::Graphics::blackjack_banner
    @winner = false
    players = Array.new # Create an array to store two players
    deck = self.make_deck
    unless !name.nil?
      name = self.get_name
    end

    @dealer = Player.new("Dealer")
    player = Player.new(name)
    players = [@dealer, player]

    @players, @deck = players, deck
    unless validate_num_players == true
      Blackjack.new
    end

    self.deal
    #self.play
  end

  def play
    # STEP 1: Bets
    scoreboard
    # Begin scoring logic
    scoring_logic

  end

  def scoreboard

    Blackjack::Graphics::clear_screen
    Blackjack::Graphics::short_blackjack_banner

    @players.each do |player|
      puts ""
      case player.name 
      when "Dealer"
        if @dealer.score == 21
          blackjack @dealer
        else
          first_num = @dealer.hand.cards.first
          puts "#{@dealer.name} has #{first_num.print_number} visible points."
          puts "#{@dealer.hand.cards.first.print}"
          puts "**  Hidden cards: (#{@dealer.hand.cards.length - 1})  **"
        end

      else
        if player.score == 21
          blackjack player
        else
          # Printing actual value of cards here
          puts "\n#{player.name} has #{player.hand.points} points and #{player.hand.cards_in_hand} cards in hand.\n"
          puts "#{player.hand.show_cards}\n"
        end
      end
    end
    nil
  end

  def scoring_logic

    @players.each do |player|
      case player.name
      when "Dealer"
        if player.score == 21
          blackjack player
        elsif player.score > 21
          aces = player.hand.aces?
          if aces > 0
            aces.times do 
              player.score -= 10
            end
            unless player.score >= 17
              self.draw_one player
              self.play
            end
          end
          blackjack @players.last
        elsif player.score < 17 
          self.draw_one player
          scoreboard
        elsif player.score >= 17
          player.stand = true
        end

      else
        if player.score == 21
          blackjack player
        elsif player.score > 21
          aces = player.hand.aces?
          if aces > 0
            aces.times do 
              player.score -= 10
            end
          elsif aces == 0
            # Is this necessary?
            # => player.busted = true
            blackjack @dealer
          end
        else
          if player.stand == true
            high_score_winner
          else
            self.draw? player
            scoreboard
          end
        end
      end # End case loop

    end # End @players loop
  end # End scoring_logic

  def get_points
    @players.each do |player|
      if (player.hand.cards.map {|card| card.number }.inject(:+)) == 21
        blackjack player
      end
    end
  end

  def validate_num_players
    if @players.length > 2
      BlackjackErrors.too_many_players
      return false
    elsif @players.length < 2
      BlackjackErrors.not_enough_players
      return false
    else
      return true
    end
  end

  def get_name
    puts "\nWhat's your name?\n"
    name = gets.chomp
    if name.is_a? String
      @name = name
    else
      raise BlackjackErrors::NameError
      self.get_name
    end
  end

  def deal
    @players.each do |player|
      player.hand.cards << @deck.shift(2)
      player.hand.cards.flatten!
    end
  end

  def draw? player
    puts "Would you like to [h]it or [s]tand?"
    input = gets.chomp
    if 'h'.include? input
      draw_one player
      play
    elsif 's'.include? input
      player.stand = true
      scoreboard
      high_score_winner
    else
      puts "Please type h for hit, or s for stand."
      self.draw? player
    end
    self.play
  end

  def draw_one player
    player.hand.cards << @deck.shift(1)
    player.hand.cards.flatten!
    self.play
    nil
  end

  def make_deck
    deck = Deck.new
    deck = deck.deck.shuffle
  end

  def high_score_winner
    high_score = []
    @players.each do |player|
      if high_score.empty?
        unless player.score > 21
          high_score = [player, player.score]
        end
      elsif player.score <= 21 && player.score > high_score[1]
        high_score = [player, player.score]
      elsif player.score == @dealer.score
        @winner = [@dealer, @dealer.score]
      end
    end
    @winner = high_score.first
    blackjack @winner
  end

  def blackjack player
    puts "We have a winner, #{player.name} has won with #{player.score} points!"
    sleep(5)
    Blackjack::Gameloop.play_again?
  end

end # Blackjack class
###       BLACKJACK        ###
##############################

class Blackjack::Gameloop

  def initialize
    game = Blackjack.new
    game.play
  end

  def self.play_again?
    puts "Would you like to play again?"
    input = gets.chomp
    if ['yes', 'y'].include? input.downcase
      Blackjack::Gameloop.new
    elsif ['no', 'n'].include? input.downcase
      puts "Thanks for playing"
      abort
    else
      self.play_again?
    end
  end

end


##############################
###    BLACKJACK BANNER    ###

class Blackjack::Graphics
  def self.blackjack_banner
    clear_screen
    puts     "\n\n"
    puts     "       *** ***                   @@@@        "
    puts     "      *********               @@  @@  @@     "
    puts     "       *******               @@@@@@@@@@@     " 
    puts     "         ***                  @@ @@@ @@      "
    puts     "          *                     @@@@@        "
    puts     "                  BLACKJACK                  "
    puts     "          *                       *          "
    puts     "         ***                    *   *        "
    puts     "        *****                 *       *      "
    puts     "       *******                  *   *        "
    puts     "          *                       *          "
    sleep(2)
  end

  def self.short_blackjack_banner
    puts     "******************    BLACKJACK    ******************"
  end

  def self.clear_screen
    puts `clear`
  end
end
###    BLACKJACK BANNER    ###
##############################





######################
#   BLACKJACK CARD   #


class Blackjack::Card < Card
  attr_reader :number, :suit

  def initialize suit, number
    super
  end

  def real_value
    case self.number
      when 11
        10
      when 12
        10
      when 13
        10
      when 14
        11
      else
        self.number
    end
  end

  def + other_card 
    self.real_value + other_card.real_value
  end

  def > other_card
    self.real_value > other_card.real_value
  end

  def < other_card
    self.real_value < other_card.real_value
  end

  def print_card
    puts "#{self.real_value} of #{@suit.to_s}"
  end

end # end Blackjack::Card class
### BLACKJACK CARD ###
######################


####################
###  DECK ERRORS ###

class DeckErrors < RuntimeError
  def self.invalid_suit
    print "Please use a valid suit: Hearts, Clubs, Diamonds, or Spades.\n"
    abort
  end
  
  def self.invalid_number
    print "Please use a valid number: 2-10, Jack, Queen, King or Ace.\n"
    abort
  end
end #DeckErrors
#   DECK ERRORS    #
####################

######################
## BLACKJACK ERRORS ##


class BlackjackErrors < RuntimeError

  def not_enough_players
    print "\nYou must have at least two players to play.\n"
  end

  def too_many_players
    print "\nSorry but you can't have more than 10 players.\n"
  end

  def yes_or_no
    print "\nPlease answer using yes/y or no/n.\n"
  end

  def bust
    print "You've busted!"
  end

  def value_not_specified
    print "PLease use a value to create a new #{self.object}."
  end

  def name_error
    print "Please enter your name."
  end

end
#  BLACKJACK ERRORS  #
######################


####################
###     BET      ###


class Bet

  def initialize
  end

  def b_e_t player
    puts "Would you like to bet? Use [b]et or [s]tay."
    input = gets.chomp
    if ['b', 'bet'].include? input
      puts "Something"
    elsif ['s', 'stand'].include? input
      puts "Something else"
    end
  end

end
#       BET        #
####################


Blackjack::Gameloop.new
