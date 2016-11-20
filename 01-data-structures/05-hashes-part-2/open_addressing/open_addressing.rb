require_relative 'node'

class OpenAddressing
  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    i = index(key, size)
    n = Node.new(key, value)

    # COLLISION!
    i = next_open_index(i) if @items[i]
    if i == -1
      resize
      i = index(key,size)
    end

    @items[i] = n
  end

  def [](key)
    i = index(key,size)
    item = @items[i]
    return item.value if item && item.key == key
    (0...size).each do |x|
      item = @items[x]
      return item.value if item.key == key
    end
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Given an index, find the next open index in @items
  def next_open_index(index)
    i = index + 1
    i = 0 if i == size
    while(@items[i])
      i += 1
      i = 0 if i == size
      return -1 if i == index
    end
    return i
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

  # Resize the hash
  def resize
    new_size = size*2
    new_items = Array.new(new_size)
    (0...size).each do |x|
      item = @items[x]
      if item
        i = index(item.key,new_size)
        if new_items[i]
          j = i + 1
          j = 0 if j == new_items.size
          while(new_items[p])
            j += 1
            j = 0 if j == new_items.size
          end
          i = j
        end
        new_items[i] = item
      end
    end

    @items = new_items
  end
end
