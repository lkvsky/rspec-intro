class TreeNode
  attr_accessor :parent, :left_child, :right_child, :value

  def initialize(value=nil)
    @parent, @value = nil, value
  end

  def left_child=(value)
    if !@left_child.nil?
      old_left = @left_child
      old_left.parent == nil
    end
    @left_child = value
    @left_child.parent = self
  end

  def right_child=(value)
    if !@right_child.nil?
      old_right = @right_child
      old_right.parent == nil
    end
    @right_child = value
    @right_child.parent = self
  end

  def bfs

  end

end