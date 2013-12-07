
class Blackjack
  attr_accessor :player, :dealer, :deck

  def initialize(player, dealer, n_decks)
    @player = player
    @dealer = dealer
    @num_decks = n_decks
    @deck   = Deck.new(@num_decks)
    @dealer_score = 0
    @player_score = 0
    @game_over = false
  end

  def run
    while true
      deck.shuffle!
      deal
      blackjack?

      puts "\n\n"

      puts @dealer
      puts
      puts @player

      hit_or_stand
      hit_dealer

      if @game_over == false
        winner?
      end
    end
  end

  def round_over(msg, winner)
    @game_over = true
    if winner == 'dealer'
      @dealer_score += 1
    elsif winner == 'player'
      @player_score += 1
    end
    puts "\n\n\n\n"
    puts "#{msg}"
    puts "\n\n\n\n"
    puts "Score is #{dealer.name} on #{@dealer_score} and #{player.name} on #{@player_score}"
    puts
    puts "Deal again? (y/n)"
    again = gets.chomp
    if again == 'n'
      exit
    elsif again == 'y'
      restart
    end
  end

  def blackjack?
    if @player.hand.value == 21
      round_over("BLACKJACK!, #{player.name} WINS")
    elsif @dealer.hand.value == 21
      round_over("#{dealer.name} has blackjack, #{player.name}, you LOSE")
    end
  end

  def winner?
    if self.player.hand.value > self.dealer.hand.value
      round_over("#{player.name}, you WON!", 'player')
    elsif self.dealer.hand.value > self.player.hand.value
      round_over("#{dealer.name} win, you LOSE", 'dealer')
    else
      round_over("It's a DRAW", nil)
    end
  end

  def restart
    self.player.hand = Hand.new
    self.dealer.hand = Hand.new
    self.deck = Deck.new(@num_decks)
    game_over = false
  end

  def deal
    self.player.hit(self.deck.draw)
    self.dealer.hit(self.deck.draw)
    self.player.hit(self.deck.draw)
    self.dealer.hit(self.deck.draw)
  end

  def hit_or_stand
    while true
      puts
      puts " => 'hit' or 'stand'?"
      ans = gets.chomp

      if ans == 'hit'
        self.player.hit(self.deck.draw)
        puts player
        if player.bust?
          round_over("Dealer wins, you went BUST...", 'dealer')
          break
        end
      elsif ans == 'stand'
        break
      end
    end
  end

  def hit_dealer
    while true
      if self.dealer.hand.value < 17
        self.dealer.hit(self.deck.draw)
        puts dealer
        if self.dealer.bust?
          round_over("Dealer went bust, you WIN!", 'player')
          break
        end
      else
        break
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
    self.cards.each do |c|
      hand_string = hand_string + "#{c}, "
    end
    hand_string + "with a value of #{@value}"
  end

  def calculate_value
    val = 0
    aces_count = 0
    cards_aceless = @cards.reject do |card|
                      if card.rank == 'Ace'
                        aces_count += 1
                        false
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
    "#{name} has: \n\n #{hand}"
  end

  def hit(drawn_card)
    @hand.add(drawn_card)
  end

  def stand
    "#{name} stands"
  end

  def bust?
    if @hand.value > 21
      true
    end
  end
end

def say(msg)
  puts " => #{msg}"
end


# GAME HERE
puts "Ready to play some blackjack?"
say("What is your name?")
temp_name = 'muam' # gets.chomp

player = Player.new(temp_name)
dealer = Player.new('Dealer')

say("How many decks would you like?")
temp_num_decks = 5 # gets.chomp.to_i

#deck = Deck.new(temp_num_decks)

game = Blackjack.new(player, dealer, temp_num_decks)

game.run