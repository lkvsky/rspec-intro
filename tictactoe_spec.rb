require 'rspec'
require_relative 'tictactoe'

describe TicTacToe do
  subject(:game) { TicTacToe.new }

  describe "#buildboard" do
    it "should return a 3x3 two dimensional array" do
      game.buildboard.should == [[nil, nil, nil],[nil, nil, nil],[nil, nil, nil]]
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

describe ComputerPlayer do
  
end