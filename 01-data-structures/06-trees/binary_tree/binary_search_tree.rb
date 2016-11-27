require_relative 'node'

class BinarySearchTree

  def initialize(root)
    @root = root
    @tree_size = 1
  end

  def insert(root, node)
    if node.rating <= root.rating
      if root.left  
        insert(root.left, node)   
      else
        root.left = node
        node.parent = root
        @tree_size += 1
      end
    else
      if root.right 
        insert(root.right, node) 
      else
        root.right = node
        node.parent = root
        @tree_size += 1
      end
    end
  end

  # Recursive Depth First Search
  def find(root, data)
    return nil if !data
    return root if root.title == data
    search = find(root.left, data) if root.left
    return search if search
    search = find(root.right, data) if root.right
    return search 
  end

  def delete(root, data)
    return nil if !data
    node = find(root, data)
    node.parent.left == node ? parent_position = true : parent_position = false
    if !node.left && !node.right
      parent_position ? node.parent.left = nil : node.parent.right = nil
    elsif node.left && node.right
      bottom_left = find_bottom_left(node)
      parent_position ? node.parent.left = bottom_left : node.parent.right = bottom_left
      bottom_left.left = node.left if node.left != bottom.left
      bottom_left.parent.left = nil
      bottom_left.parent = node.parent
    else
      if node.left
        parent_position ? node.parent.left = node.left : node.parent.right = node.left
      else
        parent_position ? node.parent.left = node.right : node.parent.right = node.right
      end
    end
    @tree_size -= 1
  end

  def find_bottom_left(node)
    return node.left if node.left.left == nil
    return find_bottom_left(node.left)
  end

  # Recursive Breadth First Search
  def printf(children=nil)
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
tree = BinarySearchTree.new(first)

tree.insert(first, second)
tree.insert(first, third)
tree.insert(first, fourth)
tree.insert(first, fifth)
tree.insert(first, sixth)
tree.insert(first, seventh)
tree.insert(first, eighth)
tree.insert(first, ninth)
tree.insert(first, tenth)
tree.insert(first, eleventh)
tree.insert(first, twelfth)
tree.insert(first, thirteenth)
tree.insert(first, fourteenth)
tree.insert(first, fifteenth)
tree.insert(first, sixteenth)
puts ""
tree.printf
puts ""
tree.a_different_print
puts ""
