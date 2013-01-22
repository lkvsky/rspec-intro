require 'rspec'
require_relative 'blackjack'

include Blackjack # brings in the module


describe Card do

  it "has a suit and a value" do
    c = Card.new(:spades, :deuce)
    c.suit.should eq(:spades)
    c.value.should eq(:deuce)
  end

end

describe Deck do

  subject(:deck) { Deck.new }

  it "should contain 52 cards" do
    deck.cards.count.should == 52
  end

  it "should contain all unique cards" do
    deck.cards.uniq.count.should == 52
  end

  it "should shuffle the deck" do
    original = deck.cards.dup
    deck.shuffle.should_not eq(original)
  end

  describe '#take' do
    subject(:deck2) do
      Deck.new([Card.new(:spades, :duece),
                Card.new(:hearts, :jack)])
    end

    it "should allow you to take n cards" do
      original = deck2.cards.dup
      deck2.take(2).should include(original[0])
    end

    it "should remove cards from the deck" do
      deck2.take(2)
      deck2.cards.should be_empty
    end
  end

  describe '#return' do
    subject(:deck3) do
      Deck.new([Card.new(:spades, :duece),
                Card.new(:spades, :three),
                Card.new(:spades, :four),
                Card.new(:spades, :five)])
    end

    it "should allow you to return cards to deck" do
      returned = deck3.take(2)
      deck3.cards.count.should == 2
      deck3.return(returned)
      deck3.cards.count.should == 4
    end

    it "should return cards to the bottome of deck" do
      cards = deck3.cards.dup
      cards[0], cards[1], cards[2], cards[3] = cards[2], cards[3], cards[0], cards[1]
      returned = deck3.take(2)
      deck3.return(returned)
      deck3.cards.should == cards
    end

  end

end

describe Hand do
  subject(:deck) { Deck.new }
  subject(:hand) { Hand.from_deck(deck) }

  it "begins with two cards" do
    hand.cards.count.should == 2
  end

  describe "#value" do
    context "with low standard hand" do
      subject(:reg_hand) { Hand.new([Card.new(:spade, :deuce),
                                    Card.new(:spade, :ace)]) }

      it "calculates a default ace point value" do
        reg_hand.points.should == 13
      end
    end

    context "with edge case ace hand" do
      it "calculates point value of complicated ace hand" do
        complex_hand = Hand.new([Card.new(:spade, :nine),Card.new(:heart, :ace), Card.new(:diamond, :nine)])
        complex_hand.points.should == 19
      end
    end
  end

  it "should bust over 21" do
    bust_hand = Hand.new([Card.new(:diamond, :ten), Card.new(:spade, :nine), Card.new(:heart, :five)])
    bust_hand.should be_busted
  end

  describe "#hit" do
    let(:hit_deck) {double("Deck", :cards => [Card.new(:diamond,:nine)])}

    it "adds a card to the player's hand" do
    hit_hand = Hand.new([Card.new(:spade,:deuce), Card.new(:heart, :deuce)])
      hit_deck.should_receive(:take).with(1).and_return(hit_deck.cards)
      hit_hand.hit(hit_deck)
    end

    it "raises exception if busted" do
      busted_hand = Hand.new([Card.new(:spade,:deuce), Card.new(:heart, :ten), Card.new(:diamond, :queen)])
      expect do
        busted_hand.hit(hit_deck)
      end.to raise_error("already busted")
    end
  end

  describe "hand comparison" do

    subject(:player_hand) { Hand.new([Card.new(:spade,:ten), Card.new(:heart, :six)])}

    it "should return true if player hand is larger" do
      dealer_hand = Hand.new([Card.new(:heart, :ten), Card.new(:heart,:deuce)])
      player_hand.beats?(dealer_hand).should be_true
    end

    it "should return false if player hand is smaller or equal" do
      dealer_hand = Hand.new([Card.new(:heart, :ten), Card.new(:heart,:ten)])
      player_hand.beats?(dealer_hand).should be_false
    end

    context "busting" do
      subject(:bust_hand) { Hand.new([Card.new(:heart, :ten), Card.new(:heart,:deuce), Card.new(:heart, :queen)])}

      it "should raise error if calling hand is busted" do
        expect { bust_hand.beats?(player_hand) }.to raise_error("busted")
      end

      it "should return true if other hand is busted" do
        player_hand.beats?(bust_hand).should be_true
      end

    end
  end
end

describe Player do
  # let(:hand) { double("Hand", :cards => [Card.new(:spade,:ten), Card.new(:heart, :six)]) }
  let(:money) { 1000 }
  let(:name) { "Kyle" }

  subject(:player) { HumanPlayer.new(name, money) }
  its(:name) { should be_a(String) }
  its(:money) { should eq(money) }
  its(:hand) { should be_nil }

  describe HumanPlayer do
    let(:dealer) { double("Dealer", :bets => {} ) }

    before(:each) do
      dealer.stub(:take_bet)
      dealer.stub(:pay_winnings).and_return(200)
    end

    it "should be able to place a bet" do
      player.place_bet(dealer, 100)
      player.money.should == 900
    end

    it "shouldn't allow bets greater than bankroll" do
      expect { player.place_bet(dealer, 1000000) }.to raise_error("broke")
    end

    it "should pass bet to dealer" do
      dealer.should_receive(:take_bet).with(player, 100)
      player.place_bet(dealer, 100)
    end

    it "should take money from dealer if hand wins" do
      player.place_bet(dealer, 100)
      player.take_winnings(dealer, 200)
      player.money.should == 1100
    end

  end

  describe Dealer do
    let(:name) { "Erik" }
    subject(:dealer) { Dealer.new(name) }
    its(:bets) { should be_a(Hash) }

    let(:player) { double("Human Player", :money => 100000000001)}

    it "should take bets" do
      dealer.take_bet(player, 100)
      dealer.bets.should == { player => 100 }
    end

    describe "#pay_winnings" do
      it "to player" do # zero bets, call player's add money method
        dealer.take_bet(player, 100)
        player.should_receive(:take_winnings).with(dealer, 200)
        dealer.pay_winnings
      end

      it "should zero bets" do
        dealer.take_bet(player, 100)
        player.should_receive(:take_winnings).with(dealer, 200)
        dealer.pay_winnings
        dealer.bets.should == {}
      end
    end

    it "should hit up to 17" do
      dealer.hand = double("dealer's hand", [:cards => Card.new(:spades, :ten), Card.new(:hearts, :deuce)])
    end
  end

end






































