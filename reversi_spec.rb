require 'rspec'
require_relative 'reversi'

RSpec.configure do |c|
  c.color = true
end

include Reversi

describe Tile do
  subject(:blue_tile) { Tile.new(:b) }
  its(:color) { should eq(:b) }

  describe "#flip" do
    it "should change colors" do
      blue_tile.flip
      blue_tile.color.should eq(:r)
    end
  end

  describe "self.adjacents" do
    it "should return the adjacent directions" do
      Tile.adjacents.should be_a_kind_of(Array)
      Tile.adjacents.count.should == 8
    end
  end
end

describe Player do
  let(:game) { double("Game") }

  subject(:player) { Player.new(:b, game) }
  its(:color) { should eq(:b) }

  let(:tile) { double("Tile", :color => :b) }

  describe "#move" do
    it "should return position on board" do
      game.should_receive(:take_move)
      player.move(0, 0).should == [0, 0]
    end

    it "should tell board who we are and where we're going" do
      game.should_receive(:take_move).with([0, 0], player)
      player.move(0, 0)
    end
  end
end

describe Game do
  subject(:game) { Game.new }
  its(:board) { should be_a_kind_of(Array) }

  let(:player) { double("Player", :color => :b) }

  describe "#initialize" do
    it "should create an 8x8 board" do
      # Rows
      game.board.length.should == 8
      # Cols
      game.board[7].length.should == 8
    end

    it "should have default starting tiles" do
      center_coords = [[3, 3], [3, 4], [4, 3], [4, 4]]
      center_coords.each do |row,col|
        game.board[row][col].should be_a_kind_of(Tile)
      end
    end

    it "should have alternating color tiles" do
      reds = [[3, 3], [4, 4]]
      blues = [[3, 4], [4, 3]]
      reds.each { |row,col| game.board[row][col].color.should == :r }
      blues.each { |row,col| game.board[row][col].color.should == :b }
    end
  end

  describe "#pick_tile" do
    it "should initialize a new tile object" do
      game.pick_tile(player).should be_a_kind_of(Tile)
    end

    it "should return a tile with the player's color" do
      game.pick_tile(player).color.should == :b
      game.pick_tile(player).color.should_not == :r
    end
  end

  describe "#valid_position?" do
    it "should be on the board" do
      low_move, high_move, legit_move = [-1, -1], [8, 8], [5, 5]
      game.valid_position?(low_move).should be_false
      game.valid_position?(high_move).should be_false
      game.valid_position?(legit_move).should be_true
    end
  end

  describe "#take_move" do
    it "should raise error if invalid move" do
      expect { game.take_move(player, [8, 8]) }.to raise_error
    end

    it "should call pick_tile" do
      game.should_receive(:pick_tile).with(player)
      game.take_move(player, [2, 3])
    end

    it "should place the tile at the provided coordinates" do
      game.take_move(player, [2, 3])
      game.board[2][3].should be_a_kind_of(Tile)
    end
  end

  describe "#find_adjacents" do
    it "should return adjacent coordinates" do
      game.find_adjacents([3, 3]).count.should == 8
      game.find_adjacents([0, 0]).count.should == 3
    end

    it "should keep track of tile objects with opposite color"
    it "search in that direction until kin is found or until invalid"
  end


end





