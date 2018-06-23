require_relative "00_tree_node"

class KnightPathFinder
  
  attr_accessor :start_pos, :visited_positions, :move_tree, :start_node
  
  def initialize(pos)
    @start_pos = pos
    @visited_positions = [pos]
    @move_tree = []
    @start_node = PolyTreeNode.new(start_pos)
    build_move_tree
  end
  
  def build_move_tree
    queue = [@start_node]
    
    until queue.empty?
      avail_moves = new_move_positions(@start_pos)
      avail_moves.each do |move|
        child_node = PolyTreeNode.new(move)
        child_node.parent = queue[0]
        queue.push(child_node)
      end
      move_tree << queue.shift 
      @start_pos = queue[0].value unless queue[0].nil?
    end
    
    move_tree          
  end
  
  def self.valid_moves(pos)
    valid_pairs = []
    (0..7).each do |row|
      (0..7).each do |col|
        pair = [row, col]
        
        if pos[0] + 2 == row || pos[0] - 2 == row
          valid_pairs << pair if (pos[1] + 1 == col || pos[1] - 1 == col)
        elsif pos[0] + 1 == row || pos[0] - 1 == row
          valid_pairs << pair if (pos[1] + 2 == col || pos[1] - 2 == col)
        end
        
      end
    end
    valid_pairs
  end
  
  
  def new_move_positions(pos)
    new_moves = []
    KnightPathFinder.valid_moves(pos).each do |move|
      new_moves << move unless visited_positions.include?(move)
    end
    visited_positions.concat(new_moves)
    new_moves
  end
  
  def find_path(end_pos)
    end_node = @start_node.dfs(end_pos)
    trace_path_back(end_node)
  end
  
  def trace_path_back(end_node)
    path = []
    current_node = end_node
    until current_node == start_node
      path.unshift(current_node.value)
      current_node = current_node.parent
    end
    path.unshift(start_node.value)
    path
  end
      

end

# p kpf = KnightPathFinder.new([0, 0])
# p kpf.find_path([7, 6]) == [[0, 0], [1, 2], [2, 4], [3, 6], [5, 5], [7, 6]]
# p kpf.find_path([6, 2]) == [[0, 0], [1, 2], [2, 0], [4, 1], [6, 2]]

