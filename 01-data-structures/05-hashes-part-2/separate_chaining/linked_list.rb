require_relative 'node'

class LinkedList
  attr_accessor :head
  attr_accessor :tail

  # This method creates a new `Node` using `data`, and inserts it at the end of the list.
  def add_to_tail(node)
    @head ||= node
    @tail.next = node if @tail
    @tail = node
    @tail.next = nil
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