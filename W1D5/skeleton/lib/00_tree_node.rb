class PolyTreeNode

  attr_reader :parent, :value
  attr_accessor :children

  def initialize(value)
    @parent = nil
    @children = []
    @value = value
  end

  def parent=(node)
    @parent.children.delete(self) if @parent
    @parent = node
    if node && !node.children.include?(self)
      node.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    raise "Not a child" if !self.children.include?(child_node)
    child_node.parent = nil
  end

  def dfs(target_value)
    return self if @value == target_value
    @children.each do |child|
      result = child.dfs(target_value)
      return result if result
    end
    nil
  end

  def bfs(target_value)
    queue = [self]

    while !queue.empty?
      current = queue.shift
      return current if current.value == target_value
      current.children.each do |child|
        queue.push(child)
      end
    end
    nil

  end

end
