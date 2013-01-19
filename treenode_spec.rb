require 'rspec'
require_relative 'treenode'

describe TreeNode do
  subject(:node) { TreeNode.new }

  describe "#parent" do
    let(:node_parent) { double("node_parent") }

    it "should be nil if it's the root of the tree" do
      node.parent.should be_nil
    end

    it "should be able to set a node's parent" do
      node.parent = node_parent
      node.parent.should == node_parent
    end
  end

  describe "#left_child" do
    subject(:left_child) { TreeNode.new }
    subject(:old_left) { TreeNode.new }

    it "should set a left child for the node" do
      node.left_child = left_child
      node.left_child.should == left_child
    end

    it "should set the child's parent to be the node" do
      node.left_child = left_child
      left_child.parent.should == node
    end

    it "should set previous left_child to nil if it existed" do
      node.left_child = left_child
      old_left.parent.should be_nil
    end
  end

  describe "#right_child" do
    subject(:right_child) { TreeNode.new }
    subject(:old_right) { TreeNode.new }

    it "should set a left child for the node" do
      node.right_child = right_child
      node.right_child.should == right_child
    end

    it "should set the child's parent to be the node" do
      node.right_child = right_child
      right_child.parent.should == node
    end

    it "should set previous right_child to nil if it existed" do
      node.right_child = right_child
      old_right.parent.should be_nil
    end
  end

  describe "#value" do
    it "should set a node's value" do
      node.value = 1
      node.value.should == 1
    end
  end

  describe "#bfs" do
    
  end

end

