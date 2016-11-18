require_relative 'node'
require 'benchmark'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    @head ||= node
    @tail.next = node if @tail
    @tail = node
  end

  # This method removes the last node in the lists and must keep the rest of the list intact.
  def remove_tail
    if !@head.next
      @head = nil
      @tail = nil
    else
      temp = @head
      while(temp.next.next)
        temp  = temp.next
      end
      temp.next = nil
      @tail = temp
    end
  end

  # This method prints out a representation of the list.
  def print
    temp = @head
    puts temp.data
    while(temp.next)
      temp = temp.next
      puts temp.data
    end
  end

  # This method removes `node` from the list and must keep the rest of the list intact.
  def delete(node)
    if @head == node
      @head = @head.next
    else
      temp = @head
      while(temp.next)
        if temp.next == node
          @tail = temp if @tail == temp.next
          temp.next = temp.next.next
          break
        end
        temp = temp.next
      end
    end
  end

  # This method adds `node` to the front of the list and must set the list's head to `node`.
  def add_to_front(node)
    node.next = @head if @head
    @tail = node if !@head
    @head = node
  end

  # This method removes and returns the first node in the Linked List and must set Linked List's head to the second node.
  def remove_front
    @head = @head.next
  end
end

array = []
ll = LinkedList.new

puts "Storing 1 to 1000000 in an array"
puts Benchmark.measure {
  (0...1000000).each do |x|
    array[x] = x
  end
}

puts "Storing 1000000 nodes in a linked list"
puts Benchmark.measure {
  (0...1000000).each do |x|
    node = Node.new(x)
    ll.add_to_tail(node)
  end
}

puts "Accessing the 500000th element of an array"
puts Benchmark.measure {
  a = array[499999]
}

puts "Accessing the 500000th element of a linked list"
puts Benchmark.measure {
  n = ll.head
  (1..500000).each do
    n = n.next
  end
}

puts "Removing 500000th element from array"
puts Benchmark.measure {
  (500000...1000000).each do |x|
    array[x-1] = array[x]
  end
  array.delete_at(999999)
}

n = ll.head
(1..500000).each do
  n = n.next
end

puts "Removing 500000th element from linked list"
puts Benchmark.measure {
  ll.delete(n)
}
