require 'rspec'
require_relative 'tictactoe'

describe TicTacToe do
  subject(:game) { TicTacToe.new }
  its(:pieces) { should eq({1 => :x, 2 => :o})}

  describe "#build_board" do
    it "should return a 3x3 two dimensional array" do
      game.build_board.should == [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
    end
  end
  describe "#valid_move?" do
    before(:each) do
      game.board = [[:x, nil, nil],
                    [:o, :x, nil],
                    [nil, :o, nil]]
    end

    it "should be an empty square" do
      bad_move, good_move = [0, 0], [0, 1]
      game.valid_move?(bad_move).should be_false
      game.valid_move?(good_move).should be_true
    end
  end

  describe "#win?" do
    it "should be 3 in a row, column or diagonal" do
    end
  end
end

describe HumanPlayer do
  let(:game) { double("TicTacToe", :pieces => {1 => :x, 2 => :o}) }

  subject(:human) { HumanPlayer.new(1, game) }
  its(:piece) { should eq(:x) }

  describe "#make_move" do
    it "should return an array with two values" do
      human.make_move.length.should == 2
    end
  end
end