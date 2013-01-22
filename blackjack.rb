module Blackjack

  class Card

    VALUES = {
      :deuce => 2,
      :three => 3,
      :four => 4,
      :five => 5,
      :six => 6,
      :seven => 7,
      :eight => 8,
      :nine => 9,
      :ten => 10,
      :jack => 10,
      :queen => 10,
      :king => 10,
      :ace => 11
    }

    SUITS = [
      :spades,
      :hearts,
      :diamonds,
      :clubs
    ]

    def self.values
      VALUES.keys
    end

    def self.suits
      SUITS
    end

    attr_reader :suit, :value

    def initialize(suit, value)
      @suit = suit
      @value = value
    end

    def blackjack_values
      VALUES[@value]
    end

  end

  class Deck

    def self.build_deck
      Card.suits.product(Card.values).map { |s,v| Card.new(s,v) }
    end

    attr_reader :cards

    def initialize(cards = Deck.build_deck)
      @cards = cards
    end

    def shuffle
      @cards.shuffle!
    end

    def take(n)
      taken = []
      n.times do
        taken << @cards.pop
      end
      taken
    end

    def return(cards)
      cards.each { |card| @cards.unshift(card) }
    end

  end

  class Hand

    def self.from_deck(deck)
      cards = deck.take(2)
      Hand.new(cards)
    end

    attr_accessor :cards

    def initialize(cards)
      @cards = cards
    end

    def points
      hand_value = 0
      aces = 0
      @cards.each do |card|
        if card.value == :ace
          aces += 1
        else
          hand_value += card.blackjack_values
        end
      end
      hand_value += aces
      if hand_value <= 11 && aces > 0
        hand_value += 10
      end
      hand_value
    end

    def busted?
      points > 21
    end

    def hit(deck)
      if !busted?
        @cards += deck.take(1)
      else
        raise "already busted"
      end
    end

    def beats?(other_hand)
      raise "busted" if busted?
      return true if points > other_hand.points || other_hand.busted?
      false
    end

  end

  class Player

    attr_reader :name
    attr_accessor :hand

    def initialize(name)
      @name = name
      @hand = nil
    end

  end

  class HumanPlayer < Player

    attr_reader :money

    def initialize(name, money)
      @money = money
      super(name)
    end

    def place_bet(dealer, amount)
      raise "broke" if amount > @money
      @money -= amount
      dealer.take_bet(self, amount)
    end

    def take_winnings(dealer, amount)
      dealer.pay_winnings(self, amount)
      @money += amount
    end

  end

  class Dealer < Player
    attr_accessor :bets

    def initialize(name)
      @bets = {}
      super(name)
    end

    def take_bet(player, amt)
      @bets[player] = amt
    end

    def pay_winnings
      @bets.each { |player, amt| player.take_winnings(self, amt*2) }
      @bets = {}
    end
  end

  class Game

  end

end