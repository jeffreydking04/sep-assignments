class MyQueue
  attr_accessor :head
  attr_accessor :tail

  def initialize
    @queue = Array.new
    @head = nil
    @tail = nil
    @head_pointer = -1
    @tail_pointer = 0
  end

  def enqueue(element)
    @tail = element if empty?
    @head_pointer += 1
    @queue[@head_pointer] = element
    @head = element
  end

  def dequeue
    temp = @tail
    @tail_pointer += 1
    if empty?
      @head_pointer = -1
      @tail_pointer = 0
      @head = nil
      @tail = nil
    else
      @tail = @queue[@tail_pointer]
    end
    temp
  end

  def empty?
    @tail_pointer > @head_pointer
  end
end
