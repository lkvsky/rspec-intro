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

  its(:towers) { should eq([[], [], []]) }

  describe "#get_move" do
    it "should return an array" do
      tower.get_move.should be_a_kind_of(Array)
    end
  end

  describe "#valid_move?" do
    it "should return false if input does not contain two values" do
      input = [0, 1, 2]
      valid_move?(input).should == false
    end
  end
end