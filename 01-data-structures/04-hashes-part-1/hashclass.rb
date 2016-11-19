require "./hash_item.rb"

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    item = @items[index(key,size)]
    resize if item && item.value != value
    return if item && item.value == value
    while(item != nil && item.value != value && item.key != key)
      resize if item && item.value != value
      item = @items[index(key,size)]
    end
    @items[index(key,size)] = HashItem.new(key, value)
  end

  def [](key)
    item = @items[index(key,size)]
    value = item.value if item
    value ? value : nil
  end

  def resize
    new_size = size * 2
    new_array = Array.new(new_size)
    @items.each do |item|
      new_array[index(item.key,new_size)] = item if item
    end
    @items = new_array
  end

  # Returns a unique, deterministically reproducible index into an array
  # We are hashing based on strings, let's use the ascii value of each string as
  # a starting point.
  def index(key, size)
    key.sum % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end
end
