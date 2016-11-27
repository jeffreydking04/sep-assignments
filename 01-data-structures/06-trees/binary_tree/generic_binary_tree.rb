require_relative "generic_node"
require 'benchmark'

class GenericBinarySearchTree
  def initialize
    @tree_size = 0
  end

  def insert(node)
    #ensure the node has no references
    node.right = nil
    node.left = nil
    node.parent = nil

    # if tree is empty, set node to root
    if @tree_size == 0
      @root = node
      @tree_size = 1
      return
    end

    # set the pointer to the root
    pointer = @root

    # if the data goes on the right and pointer.right exists, reset pointer to pointer.right
    # or, if the data goes on the left and pointer.left exists, reset pointer to pointer.left
    while (pointer.right && node.data > pointer.data) || (pointer.left && node.data <= pointer.data)
      node.data > pointer.data ? pointer = pointer.right : pointer = pointer.left
    end

    # The pointer should now be set to a node that has an open child slot on the appropriate
    # side for the data, so insert and set parent
    node.data > pointer.data ? pointer.right = node : pointer.left = node
    node.parent = pointer

    @tree_size += 1
  end

  def find(data)
    return if !@root
    array = [@root]
    while(array[0] && array[0].data != data)
      array << array[0].right if array[0].right && data > array[0].data
      array << array[0].left if array[0].left && data < array[0].data
      array.shift
    end
    return array[0]
  end

  def delete(data)
    # assign node to be deleted and its parent to variables
    node = find(data)
    return if !node
    parent = node.parent

    # There are 3 possible states for the node: it can have no children,
    # one child, or two children.

    # No children: Simply set the node's parent's ref to it to nil
    # Special case where node to be deleted is the root
    if !node.left && !node.right
      set_parent_ref(node, nil)
    end

    # One child: Assign appropriate parent ref to the child, cutting node out.
    # If the node to be deleted was root, 
    if !node.left || !node.right
      if node.left
        node.left.parent = parent
        set_parent_ref(node, node.left)
      elsif node.right
        node.right.parent = parent
        set_parent_ref(node, node.right)
      end
    end

    # Two children: Find the bottom left node on the right side of node to be deleted
    # and replace node with it.  It is already placed on the correct side of the parent,
    # all values to the deleted nodes right were to its right because it was the left most
    # node in that chain, and it is greater than all nodes to the deleted node's left.
    # Thus the tree remains valid.
    if node.left && node.right
      swap = bottom_left(node)

      # the replacement node must ref node.left on its left in all cases
      swap.left = node.left

      # In the case where node.right is the replacement node, then it obviously has
      # no left branch, so it can be moved whole up one spot and there is no need
      # to change its right ref, nor do we need to assign its former parent ref to it
      # to nil because its former parent is being deleted from the tree
      # When it is not node.right, its right ref needs to ref the deleted node's right ref
      # and its former parent needs to no longer reference it.
      if node.right != swap
        swap.right = node.right
        swap.parent.left = nil
      end

      # Obviously its new parent is the deleted node's parent and the parent's new
      # left or right is the replacement
      swap.parent = parent
      set_parent_ref(node, swap)
    end

    @tree_size -= 1
  end

  # Setting the parent reference to a swapped in child would simply require
  # the longest line below, except in the case where the deleted node is the root,
  # in which case, the right and left references will raise errors and the root 
  # will not be set correctly.  Instead of insering those 5 lines of code repeatedly
  # in the delete method, I wrote them once here. 
  def set_parent_ref(node, swap)
    parent = node.parent
    if parent
      parent.left == node ? parent.left = swap : parent.right = swap
    else
      @root = swap
    end
  end

  def bottom_left(node)
    swap = node.right
    while swap.left
      swap = swap.left
    end
    swap
  end

  # I did this without recursion and it seems much cleaner.
  def printf
    return if !@root
    elements = []
    elements << @root
    while(elements[0])
      elements << elements[0].left if elements[0].left
      elements << elements[0].right if elements[0].right
      puts "Data: #{elements[0].data}; Parent: #{elements[0].parent.data if elements[0].parent}"
      elements.shift
    end
  end

  def a_different_print
    return if !@root
    current = 1
    count = 1
    print_node(count, @root)
    while count < @tree_size
      current += 1
      str = current.to_s(2)
      str.slice!(0)
      pointer = @root
      while str.length > 0
        direction = str.slice!(0)
        if direction == "0"
          if pointer.left
            pointer = pointer.left
          else
            pointer = nil
            break
          end
        else
          if pointer.right
            pointer = pointer.right
          else
            pointer = nil
            break
          end
        end
      end
      if pointer
        print_node(current, pointer)
        count += 1
      else
        print_node(current, nil)
      end
    end
  end

  def print_node(current, node)
    power_of_two = 2
    while current >= power_of_two
      puts "" if current == power_of_two
      power_of_two *= 2
    end
    row = 0
    temp = current
    while temp > 0
      temp /= 2
      row += 1
    end
    if node
      puts "Row: #{row}; Slot: #{current}; Data: #{node.data}"
    else
      puts "Row: #{row}: Slot: #{current}: Empty"
    end
  end
end

tree = GenericBinarySearchTree.new


array = []
(0...100000).each do |x|
  array[x] = GenericNode.new(x)
end

array.shuffle!





puts "Tree: inserts 100000 nodes: #{Benchmark.measure {
  (0...100000).each do |x|
    tree.insert(array[x])
  end
}}"

puts "Tree: finds a random node: #{Benchmark.measure {
  tree.find(50000)
}}"

puts "Tree: deletes a random node #{Benchmark.measure {
  tree.delete(49999)  
}}"
