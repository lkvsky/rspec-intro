require 'rspec'
require_relative 'week1'
describe "#my_uniq" do

  it "returns a new array" do
    original = [1, 2, 3, 4, 4, 5]
    duped_original = original.dup
    duped_original.my_uniq
    duped_original.should == original
  end

  it "shouldn't contain duplicates" do
    [1, 2, 3, 4, 4, 5].my_uniq.should == [1, 2, 3, 4, 5]
  end

end

describe "#two_sum" do
  it "should return a empty array if only one value is given" do
    [2].two_sum.should == []
  end

  it "should contain arrays containing 2 values" do
    a = [1, -1, -2].two_sum
    a.should include [0,1]
  end

  it "should contain indices of values that sum to zero" do
    [1, 2, 3, 4, -1, -2].two_sum.should == [[0, 4], [1, 5]]
  end

  it "should find both pairs if multiple sets sum to 0" do
    [1, -1, -1].two_sum.should == [[0, 1], [0, 2]]
  end

  it "shouldn't return spurious 0's" do
    [0, 1, -1].two_sum.should == [[1,2]]
  end

end

describe TowersOfHanoi do
  subject(:tower) { TowersOfHanoi.new }

  describe "#initialize" do
    its(:towers) { should eq([[3, 2, 1], [], []])}
  end

  describe "#get_move" do
    it "should return an array" do
      tower.get_move.should be_a_kind_of(Array)
    end
  end

  describe "#valid_move?" do
    before(:each) do
      tower.towers[1] = [1, 2, 3]
      tower.towers[2] = [0]
    end
    it "should return false if input does not contain two values" do
      input = [0, 1, 2]
      tower.valid_move?(input).should be_false
    end

    it "should only contain values between 0 and 2" do
      bad1, bad2 = [-1, 1], [1, 3]
      tower.valid_move?(bad1).should be_false
      tower.valid_move?(bad2).should be_false
    end

    it "should not allow larger pieces on top of smaller pieces" do
      tower.valid_move?([1,2]).should be_false
    end
  end

  describe "#make_move" do
    it "should move a value to a new tower" do
      move = [0, 1]
      tower.make_move(move)
      tower.towers[0].length.should == 2
      tower.towers[1].length.should == 1
    end
  end
end