require_relative 'linked_list'

class SeparateChaining
  attr_reader :max_load_factor

  def initialize(size)
    @items = Array.new(size)
    @item_count = 0
    @max_load_factor = 0.7
  end

  def []=(key, value)
    i = index(key, size)
    n = Node.new(key, value)

    # COLLISION!
    @items[i] != nil ? list = @items[i] : list = LinkedList.new

    list.add_to_tail(n)
    @items[i] = list
    @item_count = @item_count + 1

    # Resize the hash if the load factor grows too large
    if load_factor.to_f > max_load_factor.to_f
      resize
    end
  end

  def [](key)
    list = @items.at(index(key,size))
    if list != nil
      curr = list.head
      while curr != nil
        if curr.key == key
          return curr.value
        end
        curr = curr.next
      end
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Calculate the current load factor
  def load_factor
    @item_count / size.to_f
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

  # Resize the hash
  def resize
    new_size = size*2
    new_items = Array.new(new_size)
    (0...size).each do |i|
      list = @items[i]
      if list != nil
        curr = list.head
        new_index = index(curr.key, new_items.size)
        while curr
          temp = curr.next
          !new_items[new_index] ? list = LinkedList.new : list = new_items[new_index]
          list.add_to_tail(curr)
          new_items[new_index] = list
          curr = temp
          new_index = index(curr.key, new_items.size) if curr
        end
      end
    end

    @items = new_items
  end

  def print
    puts "Underlying array has size: #{size}"
    (0...size).each do |x|
      puts ""
      puts "Array index: #{x}"
      puts "Enpty" if !@items[x]
      next if !@items[x]
      current = @items[x].head
      while(current)
        puts "Key: #{current.key}"
        puts "Value: #{current.value}"
        current = current.next
      end
    end
    puts "Load factor is #{load_factor}"
  end
end

#hobbiton = SeparateChaining.new(1)
#hobbiton["Bilbo"] = "Baggins"
#hobbiton["Frodo"] = "Baggins"
#hobbiton.print
#
#puts ""
#puts "The hash contains the Frodo/Baggins key/value pair: #{hobbiton["Frodo"] != nil}"
#hobbiton["Sam"] = "Gamgee"
#hobbiton["Pippin"] = "Took"
#hobbiton["Merry"] = "Brandybuck"
#hobbiton.print
#puts ""
