require_relative 'generic_node'
require "benchmark"

class GenericMinBinaryHeap
  def initialize
    @heap_size = 0
  end

  def insert(node)
    # Ensure node makes no references
    node.left = nil
    node.right = nil
    node.parent = nil

    # If heap is empty, set node as root and return
    if @heap_size == 0
      @root = node
      @heap_size = 1
      return
    end

    # else find parent of first empty slot
    parent = find_parent(@heap_size + 1)

    # set node's parent ref to parent and parent's first open child to node
    node.parent = parent
    !parent.left ? parent.left = node : parent.right = node


    @heap_size += 1

    # bubble up if node.data < parent.data
    bubble_up(node) if node.data < parent.data
  end

  def bubble_up(node)
    # set all relevant relatives to variables for clarity
    parent = node.parent
    grandparent = node.parent.parent
    left_child = node.left
    right_child = node.right
    parent.left == node ? parents_other_child = parent.right : parents_other_child = parent.left

    # grandparent only needs one change: it needs to reference node as a child,
    # but only if grandparent exists; if not, then the node is the new root
    if grandparent
      grandparent.left == parent ? grandparent.left = node : grandparent.right = node
    else
      @root = node
    end
    # node will now be the next generation;  it needs to reference grandparent as parent
    node.parent = grandparent
    # it needs to reference parent on the same side that it was a child of parent
    # and parents_other_child on the other side
    if parent.left == node
      node.left = parent
      node.right = parents_other_child
    else
      node.right = parent
      node.left = parents_other_child
    end

    # parents_other_child still references parent as parent so change to node
    parents_other_child.parent = node if parents_other_child

    # left_child and right_child need to reference the old parent as their new parent
    left_child.parent = parent if left_child
    right_child.parent = parent if right_child  

    # lastly, parent needs to reference node as parent and node's previous left and right
    parent.parent = node
    parent.left = left_child
    parent.right = right_child

    # this swap is complete, but the bubble up many not be
    return if @root == node
    bubble_up(node) if node.data < grandparent.data
  end

  def delete(data)
    return if !data

    # find the node
    node = find(data)

    # find the parent of last element on the heap
    swap_parent = find_parent(@heap_size)

    # if the node is the last element on the heap, delete it by setting the ref in its parent
    if (swap_parent.left == node && !swap_parent.right) || swap_parent.right == node
      @heap_size -= 1
      swap_parent.left == node ? swap_parent.left = nil : swap_parent.right = nil
      return
    end

    # other wise replace it with the last element and set swap_parent's child ref
    # to swap to nil
    if swap_parent.right 
      swap = swap_parent.right
      swap_parent.right = nil 
    else
      swap = swap_parent.left
      swap_parent.left = nil
    end

    # when replacing a node, there are 4 possible nodes that need to have their refs changed
    # the parent node needs to reference the replacement node as a child on the correct side,
    # if deleted node was not the root; if it was root make the replacement node the root
    if node.parent
      node.parent.left == node ? node.parent.left = swap : node.parent.right = swap
    else
      @root = swap
    end

    # now the node has been excised from the heap, but so have its descendants
    # also the replacement node, swap, does not reference the parent
    swap.parent = node.parent
    swap.left = node.left
    swap.right = node.right

    # the descendants are now referenced by the replacement, but they do not reference the
    # replacement as a parent
    node.left.parent = swap if node.left
    node.right.parent = swap if node.right

    # the replacement is complete, so decrease the heap size
    @heap_size -= 1

    # but the heap might not be a valid min heap, so bubble down if necessary
    if (swap.left && swap.data > swap.left.data) || (swap.right && swap.data > swap.right.data)
      bubble_down(swap)
    end
  end

  def bubble_down(node)
    # set child with smallest data to swap variable
    if node.right
      node.left.data < node.right.data ? swap = node.left : swap = node.right
    else
      swap = node.left
    end

    # 6 potential nodes are affected: node.parent, node, swap, swap's children and node's 
    # other_child; node and swap are already assigned; assing node.parent, 
    # node's other_child, and swap's children to variables
    parent = node.parent
    node.left == swap ? other_child = node.right : other_child = node.left
    left_child = swap.left
    right_child = swap.right

    # assign swap node as child of parent unless node is @root; 
    # in which case, assign swap to root
    if @root == node
      @root = swap
    else
      parent.left == node ? parent.left = swap : parent.right = swap
    end

    # swap has been assigned to node's previous position, now assign node and other child
    # as its descendents
    if node.left == swap
      swap.left = node
      swap.right = other_child
    else
      swap.right = node
      swap.left = other_child
    end

    # other_child and node have been assigned their appropriate spots, but they still
    # do not reference swap as a parent; also node does not reference swap's former children
    other_child.parent = swap if other_child
    node.parent = swap
    node.left = left_child
    node.right = right_child

    # lastly, swap's former children are back in the heap, but they do not reference
    # node as a parent, if they exist at all
    left_child.parent = node if left_child
    right_child.parent = node if right_child

    # the swap is complete, but the heap may not be completely valid, check to see if 
    # node's data is greater than either of its new children; bubble down if so
    if (node.left && node.data > node.left.data) || (node.right && node.data > node.right.data)
      bubble_down(node)
    end
  end

  def find(data)
    return if !data

    elements = [@root]
    while elements[0]
      return elements[0] if elements[0].data == data
      elements << elements[0].left if elements[0].left
      elements << elements[0].right if elements[0].right
      elements.shift
    end
  end

  def find_parent(num)
    str = num.to_s(2)
    str.slice!(0)
    parent = @root
    while str.length > 1
      str.slice!(0) == "0" ? parent = parent.left : parent = parent.right
    end
    parent
  end

  def a_different_print
    return if !@root
    current = 1
    count = 1
    print_node(count, @root)
    while count < @heap_size
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

  def printf
    return if !@root
    elements = []
    elements << @root
    while(elements[0])
      elements << elements[0].left if elements[0].left
      elements << elements[0].right if elements[0].right
      puts "Data: #{elements[0].data}; Parent: #{elements[0].parent.data if elements[0].parent}; left: #{elements[0].left.data if elements[0].left}; right: #{elements[0].right.data if elements[0].right}"
      elements.shift
    end
  end
end

heap = GenericMinBinaryHeap.new


array = []
(0...100000).each do |x|
  array[x] = GenericNode.new(x)
end

array.shuffle!





puts "Heap: inserts 100000 nodes: #{Benchmark.measure {
  (0...100000).each do |x|
    heap.insert(array[x])
  end
}}"

puts "Heap: finds a random node: #{Benchmark.measure {
  heap.find(50000)
}}"

puts "Heap: deletes a random node #{Benchmark.measure {
  heap.delete(49999)  
}}"
