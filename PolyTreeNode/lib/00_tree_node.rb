require 'byebug'

class PolyTreeNode
  # attr_reader :parent, :value, :children
  
  def initialize(value)
    @value = value
    @parent = nil
    @children = []
  end
  
  def parent
    @parent
  end
  
  def children
    @children
  end
  
  def value
    @value
  end
  
  def parent=(new_parent)
    @parent.children.delete(self) unless @parent == nil
    @parent = new_parent 
    
    unless new_parent == nil
      @parent.children << self unless @parent.children.include?(self)
    end
  end 
  
  def add_child(child_node)
    child_node.parent = self
  end
  
  def remove_child(child_node)
    raise "Node is not a child" unless child_node.parent == self
    child_node.parent = nil
  end
  
  def dfs(target_value)
    return self if self.value == target_value
    children.each do |child| 
      child_search = child.dfs(target_value)
      return child_search unless child_search.nil?
    end
    nil
  end
  
  # def dfs(target_value)
  #   # byebug
  #   self.value == target_value ? self : nil
  #   children.each { |child| child.dfs(target_value) }
  # end
  
  def bfs(target_value)
    queue = []
    queue.push(self)
    
    until queue.empty?
      current_node = queue.shift
      return current_node if current_node.value == target_value
      queue.concat(current_node.children)
    end
    
    nil 
  end
  
  
end