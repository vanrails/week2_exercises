# 1. Have detailed requirements or specifications in written form.
# 2. Extract major nouns -> classes
# 3. Extract major verbs -> instance methods
# 4. Group instance methods into classes

class Card
  attr_accessor :suit, :rank

  def initialize(s, r)
    @suit = s
    @rank = r
  end

  def to_s
    "#{rank} of #{suit}"
  end
end

class Deck
  @@suits = %w(Hearts Diamonds Spades Clubs)
  @@ranks = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)

  def initialize(num_decks)
    @cards = []

    num_decks.times do
      @@suits.each do |suit|
        @@ranks.each do |rank|
          @cards.push(Card.new(suit, rank))
        end
      end
    end
  end

  def shuffle
    # shuffle cards here
  end

  def draw
    @cards.pop
  end
end

module Hit_Or_Standable
  def hit_or_stand(deck)
    while true
      puts " => 'hit' or 'stand'?"
      ans = gets.chomp

      if ans == 'hit'
        self.hit(deck.draw)
        puts @hand
      elsif ans == 'stand'
        break
      end
    end
  end
end

class Player
  include Hit_Or_Standable

  attr_accessor :hand

  def initialize(n)
    @name = n
    @hand = []
  end

  def hit(drawn_card)
    # Player draws a Card from the Deck
    @hand << drawn_card
  end

  def value

  end
end

class Dealer
  attr_accessor :name, :hand

  def initialize
    @name = 'Dealer' # default name
    @hand = []
  end

  def hit(drawn_card)
    # Dealer draws a Card from the Deck
    @hand << drawn_card
  end
end

player = Player.new('Jonny')
dealer = Dealer.new

cards = Deck.new(5)