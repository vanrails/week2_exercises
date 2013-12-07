
module Sayable
  def say(msg)
    puts " => #{msg}"
  end
end

class Blackjack
  include Sayable

  attr_accessor :player, :dealer, :deck

  def initialize
    puts 'Welcome to Blackjack!'

    @player       = get_player
    @dealer       = Player.new('Dealer')
    @deck         = get_deck
    @dealer_score = 0
    @player_score = 0
  end

  def run
    @game_over = false
    @deck = Deck.new(@num_decks)
    player.clear_hands
    dealer.clear_hands

    deck.shuffle!
    deal

    player.blackjack? && round_over('WIN')
    @game_over == false && dealer.blackjack? && round_over('LOSE')

    player_turn
    dealer_turn

    winner?
  end

  def get_player
    say('What is your name?')
    p_name = gets.chomp

    Player.new(p_name)
  end

  def get_deck
    n_decks = 0
    until n_decks > 0 && n_decks < 6
      say('How many decks would you like? (1-5)')
      n_decks = gets.chomp.to_i
    end
    @num_decks = n_decks
    Deck.new(@num_decks)
  end

  def round_over(msg)
    @game_over = true
    puts "\n\n\n#{msg}\n\n\n"
    play_again?
  end

  def play_again?
    again = ''
    until again == 'y' || again == 'n'
      say('Deal again? (y/n)')
      again = gets.chomp
    end
    again == 'y' ? run : exit
  end

  def winner?
    if @game_over == false
      if player.hand.value > dealer.hand.value
        round_over('WIN')
      elsif dealer.hand.value > player.hand.value
        round_over('LOSE')
      else
        round_over('DRAW')
      end
    end
  end

  def deal
    player.hit(deck.draw)
    dealer.hit(deck.draw)
    player.hit(deck.draw)
    dealer.hit(deck.draw)

    puts dealer
    puts player
  end

  def player_turn
    if @game_over == false
      ans = ''
      until ans.downcase == 'stand'
        say("'hit' or 'stand'?")
        ans = gets.chomp

        if ans.downcase == 'hit'
          player.hit(deck.draw)
          puts player
          player.bust? && round_over('LOSE')
        end
      end
    end
  end

  def dealer_turn
    if @game_over == false
      until dealer.hand.value > 17
        dealer.hit(deck.draw)
        puts dealer
        dealer.bust? && round_over('WIN')
      end
    end
  end
end

class Deck
  SUITS = %w(Hearts Diamonds Spades Clubs)
  RANKS = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  def initialize(num_decks)
    @cards = []

    SUITS.each do |suit|
      RANKS.each do |rank|
        @cards.push(Card.new(suit, rank))
      end
    end
    @cards = @cards * num_decks
  end

  def shuffle!
    @cards.shuffle!
  end

  def draw
    @cards.pop
  end
end

class Card
  attr_reader :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end

class Hand
  attr_accessor :cards, :value

  def initialize
    @cards = []
    @value = 0
  end

  def add(card)
    @cards << card
    calculate_value
  end

  def to_s
    hand_string = ''
    cards.each do |c|
      hand_string = hand_string + "#{c}, "
    end
    hand_string + "with a value of #{@value}"
  end

  def calculate_value
    val = 0
    aces_count = 0
    cards_aceless = @cards.dup
    cards_aceless.delete_if do |card|
      if card.rank == 'Ace'
        aces_count += 1
        true
      end
    end

    cards_aceless.each do |card|
      if card.rank.to_i == 0
        val += 10
      else
        val += card.rank.to_i
      end
    end

    aces_count.times do
      if val + 11 > 21
        val += 1
      else
        val += 11
      end
    end
    @value = val
  end
end

class Player
  attr_accessor :name, :score, :hand

  def initialize(name)
    @name = name
    @score = 0
    @hand = Hand.new
  end

  def to_s
    "\n#{name} has: \n#{hand}"
  end

  def clear_hands
    @hand = Hand.new
  end

  def hit(drawn_card)
    @hand.add(drawn_card)
  end

  def blackjack?
    hand.value == 21 && true
  end

  def bust?
    @hand.value > 21 && true
  end
end

game = Blackjack.new
game.run
