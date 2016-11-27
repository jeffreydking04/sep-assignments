require_relative 'generic_node'
require 'benchmark'

class ArrayMinHeap
  def initialize
    @array = []
  end

  def insert(node)
    # store the size of the array in a variable and push the node onto the array
    @array << node
    size = @array.size
    return if size == 1

    # the parent of the inserted node is the size of the array / 2 - 1
    # the parent of the parent is size / (2 ** 2) - 1, so on and so forth
    # while node's data is less than the next parent, keep swapping
    parent_index  = size / 2 - 1
    node_index = size - 1
    while (node.data < @array[parent_index].data)
      @array[node_index] = @array[parent_index]
      @array[parent_index] = node
      parent_index = (parent_index + 1) / 2 - 1 if parent_index != 0
      node_index = (node_index + 1) / 2 - 1
    end
  end

  def delete(data)
    index = 0
    (0...@array.size).each do |i|
      index = i
      break if @array[i].data == data
    end
    @array[index] = @array[@array.size - 1]
    replacement = @array.slice!(-1).data
    left_index = (index + 1) * 2 - 1
    right_index = (index + 1) * 2
    while (@array[left_index] && @array[left_index].data < replacement) || (@array[right_index] && @array[right_index].data < replacement)
      if @array[right_index]
        @array[left_index].data < @array[right_index].data ? swap_index = left_index : swap_index = right_index
      else
        swap_index = left_index
      end
      temp = @array[index]
      @array[index] = @array[swap_index]
      @array[swap_index] = temp
      index = swap_index
      left_index = (index + 1) * 2 - 1
      right_index = (index + 1) * 2
    end
  end

  def find(data)
    (0...@array.size).each do |i|
      return @array[i] if @array[i].data == data
    end
  end

  def printf
    (0...@array.size).each do |i|
      puts @array[i].data
    end
  end
end

heap = ArrayMinHeap.new

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