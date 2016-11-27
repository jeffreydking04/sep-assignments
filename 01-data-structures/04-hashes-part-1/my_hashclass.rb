require "./hash_item.rb"

class HashClass

  def initialize(size)
    @items = Array.new(size)
  end

  def []=(key, value)
    item = @items[index(key,size)]
    return if item && item.value == value
    while(item != nil && item.value != value && item.key != key)
      resize if item && item.value != value
      item = @items[index(key,size)]
    end
    @items[index(key,size)] = HashItem.new(key, value)
  end

  def [](key)
    value = @items[index(key,size)].value
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
    hash_function(key) % size
  end

  # Simple method to return the number of items in the hash
  def size
    @items.size
  end

  def hash_function(key)
    h = 0
    (0...key.length).each do |x|
      h = 33 * (h ^ key[x].sum )
    end
    h
  end
end