require_relative 'skeleton/lib/00_tree_node'

class KnightPathFinder

  def initialize(start_pos)
    @start_pos = start_pos
    @move_tree = PolyTreeNode.new(@start_pos)
    @visited_positions = [start_pos]
    build_move_tree
  end

  def self.valid_moves(pos)
    possible = []
    (-2..2).each do |i|
      (-2..2).each do |j|
        x = pos[0] + i
        y = pos[1] + j
        if i.abs != j.abs &&
          x.between?(0, 7) && y.between?(0, 7) &&
          i != 0 && j != 0
          possible << [x, y]
        end
      end
    end

    possible
  end

  def build_move_tree
    queue = [@move_tree]
    until queue.empty?
      parent = queue.shift
      new_move_positions(parent.value).each do |pos|
        child_node = PolyTreeNode.new(pos)
        parent.add_child(child_node)
        queue << child_node
      end
    end
  end

  def new_move_positions(pos)
    positions = KnightPathFinder.valid_moves(pos)
    positions.select do |pos|
      if !@visited_positions.include?(pos)
        @visited_positions << pos
        pos
      end
    end
  end

  def find_path(end_pos)
    node = @move_tree.dfs(end_pos)
    trace_path_back(node) if node
  end

  def trace_path_back(node)
    path = [node.value]
    current_node = node
    while current_node.parent
      parent = current_node.parent
      path << parent.value
      current_node = parent
    end
    path.reverse
  end
end
