require_relative 'node'

class MinBinaryHeap
  def initialize(root = nil)
    @root = root
    @root ? @heap_size = 1 : @heap_size = 0
  end

  def insert(node)
    # there are potentially cases in which nodes could be inserted with left and right values
    # that do not equal nil, so we immediately set them to nil to prevent unwanted references
    node.left = nil
    node.right = nil

    # I written the class in such a way as to allow for an empty heap
    # Here I test for an empty heap and set the inserted node to the root,
    # set the @heap_size to 1 and return
    if @heap_size == 0
      @root = node
      @heap_size = 1
      return
    end

    # Find the pointer (the pointer is the parent of the next slot to be filled),
    # so we set the node's parent to @pointer and @pointer's appropriate left 
    # or right reference to the node (if the stack size is even, the next empty slot is on
    # the pointer's right)
    @pointer = find_pointer(@heap_size + 1)
    node.parent = @pointer
    @heap_size.even? ? @pointer.right = node : @pointer.left = node
    # If the node has not been bubbled up to the root && its rating is less than
    # its parent's rating, it must swap with its parent
    while(node.parent && node.rating < node.parent.rating)

      # set the parent and grandparent variables and assign the node's parent to its grandparent
      parent = node.parent
      grandparent = parent.parent
      node.parent = grandparent

      # If grandparent is not nil (which would make the node the new root),
      # then appropriately set the grandparent's left or right reference to the node
      if grandparent
        grandparent.left == parent ? grandparent.left = node : grandparent.right = node
      end

      # Make the swap by first saving the node's left and right refs
      temp_left = node.left
      temp_right = node.right

      # Appropriately reset the node's left and right refs depending 
      # on whether it was on the left or right of its parent
      # Also the other child of the former parent must have its parent reset to node
      if parent.left == node
        node.left = parent
        node.right = parent.right
        node.right.parent = node if node.right
      else
        node.right = parent
        node.left = parent.left
        node.left.parent = node if node.left
      end

      # Set the parent's left and right refs to node's previous left and right refs
      parent.left = temp_left
      parent.right = temp_right

      # Set the former parent's parent ref to the node to complete the swap
      parent.parent = node

      # Set the former parent's new children to have parent refs of parent
      parent.left.parent = parent if parent.left
      parent.right.parent = parent if parent.right

      # Conditional will check to see if the node still has a parent && if that 
      # parent's rating is greater than node's rating, in which case the loop will
      # iterate again, performing the appropriate swap
    end

    # if the node has bubbled to the top of the heap, the root must be reset to the node
    @root = node if !node.parent
    @heap_size += 1
  end

  # Recursive Depth First Search
  def find(root, data)
    return nil if @heap_size == 0
    return nil if !data
    return root if root.title == data
    search = find(root.left, data) if root.left
    return search if search
    search = find(root.right, data) if root.right
    return search 
  end

  def delete(data)

    return if !data

    # Immediately return from delete if there is nothing to delete
    return if @heap_size == 0

    # Find the node and return if the node does not exist
    node = find(@root, data)
    return if !node

    # If the node exists and the heap size is 1, it must be the only node
    # Set the root to nil and the heap size to 0, return
    if @heap_size == 1
      @root = nil
      @heap_size = 0
      return
    end

    # Find the parent of the last filled slot
    @pointer = find_pointer(@heap_size)

    # If the element to be deleted is the last element on the heap, set its parent's
    # ref to it to nil
    if @pointer.right == node
      @pointer.right = nil
      return
    elsif !@pointer.right && @pointer.left == node
      @pointer.left = nil
      return
    end

    # If the pointer refs a node on its right, then that is the last node in the heap
    # Otherwise it is the node referenced on the left of the pointer
    # Set last node in heap to swap.  It will be swapped with the deleted node
    @pointer.right ? swap = @pointer.right : swap = @pointer.left

    # If the last node's parent's right ref was the swap, set the parent's right
    # ref to nil, otherwise it must have been on left, set parent's left ref to nil
    swap.parent.right == swap ? swap.parent.right = nil : swap.parent.left = nil

    # Set the parent ref of the swap node to the deleted node's parent ref
    swap.parent = node.parent

    # If the deleted node was the root node, make @root the swap node,
    # else make set the parent variable to the deleted mode's parent
    # and set the left or right ref that formerly referenced the deleted 
    # node to ref the swap node
    if node == @root
      @root = swap
    else
      parent = node.parent
      parent.left == node ? parent.left = swap : parent.right = swap
    end

    # Set the left and right refs of the swap node to the deleted nodes left and
    # right refs
    swap.left = node.left
    swap.right = node.right

    # set bubbling nodes new children's parent to ref node
    node.left.parent = node if node.left
    node.right.parent = node if node.right

    # Swap is now complete, but we need to bubble down the swap node, so
    # we call heapify with swap as the parameter
    heapify(swap)

    # Deletion and re-heapify are complete, so decrement the heap size
    # This only occurs if the requested node was actually found
    @heap_size -= 1
  end

  def heapify(node)
    # This is a recursive method that has two possible exit conditions
    # If the node has bubbled to the bottom row, its left ref should be nil,
    # in which case the heapify is complete and we return
    return if !node.left

    # We only get here if there is a left reference.  We check for the existence
    # of a right ref and then set the swap to the node that has the lower rating
    if node.right
      node.left.rating <= node.right.rating ? swap = node.left : swap = node.right
    else
      swap = node.left
    end

    # If the lower rated node's rating is greater than the bubbling node's rating
    # then we have achieved the second possible condition for exiting the recursion
    # and we return becauase the heapify is complete
    return if node.rating <= swap.rating

    # Otherwise, we must perform a swap with between the bubbling node and the swap node
    # First we check to see if the bubbling node is currently the root.  If it is, we 
    # make the swap node the root node and set the swap's node's parent ref to nil.
    # Otherwise, we set the swap's parent to the node's parent and the nodes' parent correct
    # left or right ref to the swap node
    if node == @root
      @root = swap
      swap.parent = nil
    else
      swap.parent = node.parent
      node.parent.left == node ? node.parent.left = swap : node.parent.right = swap
    end

    # The bubbling node will become a descendant of the swap node, so we set its parent
    # ref accordingly.
    node.parent = swap

    # We save the swap node's left and right refs
    temp_left = swap.left
    temp_right = swap.right

    # Then we approprately set the swap node's left and right refs dependant on 
    # whether it was the left or right ref of the bubbling node
    # Also, the former other child of the bubbling node will now have swap as its parent
    # So we need to set it accordingly
    if node.left == swap
      swap.left = node
      swap.right = node.right
      swap.right.parent = swap if swap.right
    else
      swap.right = node
      swap.left = node.left
      swap.left.parent = swap if swap.left
    end

    # Then we set the bubbling node's left and right refs to the swapped node's
    # former values.
    node.left = temp_left
    node.right = temp_right

    # The swap is complete, we recursively call heapify to see if we have
    # reached one of the two appropriate base conditions
    heapify(node)
  end

  # Recursive Breadth First Search
  def printf(children=nil)
    puts "No elements in heap" if !@root
    return if !@root
    children ? traversed = true : traversed = false
    if !traversed
      children = []
      children << @root
    end
    return if children[0] == -1
    puts "#{children[0].title}: #{children[0].rating}"
    printed = children.shift
    children[0] = -1 if children.empty? && !printed.left && !printed.right
    children << printed.left if printed.left
    children << printed.right if printed.right
    printf(children)
  end

  # This method will return the PARENT node of the desired heap element.
  # For insert, we want to find the parent of the first empty slot.
  # For delete, we want to find the parent of the last node in the heap.
  # It computes a string that consists of the binary representation
  # of the number that is passed in, without the first or last digits.
  # It then iterate through the middle digits of the string, reassigning
  # its current node to either the left or right child depending on wether
  # the digit is 0 or 1.  
  # For example, the first digit of this string will always be the second
  # digit of the binary representation of any slot number, with the root being
  # slot 1.  The second binary digit of every slot to the left of root is 0, while
  # while it is 1 for every slot on the right of root.  Neat stuff, amiright?
  def find_pointer(num)
    # We are basically bubbling down the heap, starting at the root, set appropriately
    @pointer = @root

    # The following lines convert our num to a string that is a binary representation of 
    # our number.  We slice off the first and last.  We slice the first because it 
    # is always going to be one and can be thought of to refer to the root, which we
    # have already accounted for.  We slice the second because the slot we are looking
    # for will either be the last node in the heap, or the first empty node.  We want the
    # pointer to refer to an actual node, not a position, so we find the parent node
    # of the slot we are interested in and then either add a new node to that parent
    # node or swap out the appropriate child in a deletion.  Either way, it is convenient
    # to deal with the parent node.
    str = num.to_s(2)
    str.slice!(-1)
    str.slice!(0)

    # Cycle through the digits, bubbling down to the appropriate parent; math is a beautiful thing
    while(str.length > 0)
      direction = str.slice!(0)
      direction == "0" ? @pointer = @pointer.left : @pointer = @pointer.right
    end

    # return it
    @pointer
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
      puts "Row: #{row}; Slot: #{current}; Title: #{node.title}; Rating: #{node.rating}"
    else
      puts "Row: #{row}: Slot: #{current}: Empty"
    end
  end
end

first = Node.new("Pulp Fiction", 95)
second = Node.new("Gladiator", 94)
third = Node.new("Out of Africa", 96)
fourth = Node.new("Rosenkrantz and Gildenstern Are Dead", 98)
fifth = Node.new("Chariots's of Fire", 92)
sixth = Node.new("Serenity", 93)
seventh = Node.new("Jiro Dreams of Sushi", 88)
eighth = Node.new("Daredevil", 97)
ninth = Node.new("Dumb and Dumber", 91)
tenth = Node.new("The Big Lebowski", 99)
eleventh = Node.new("Fargo", 89)
twelfth = Node.new("Blade Runner", 90)
thirteenth = Node.new("Big Trouble in Little China", 100)
fourteenth = Node.new("Thor", 86)
fifteenth = Node.new("Bull Durham", 87)
sixteenth = Node.new("Jessica Jones", 85)
tree = MinBinaryHeap.new(first)

tree.insert(second)
tree.insert(third)
tree.insert(fourth)
tree.insert(fifth)
tree.insert(sixth)
tree.insert(seventh)
tree.insert(eighth)
tree.insert(ninth)
tree.insert(tenth)
tree.insert(eleventh)
tree.insert(twelfth)
tree.insert(thirteenth)
tree.insert(fourteenth)
tree.insert(fifteenth)
tree.insert(sixteenth)
puts ""
tree.printf
puts ""
tree.a_different_print
puts ""