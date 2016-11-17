class MyStack
  attr_accessor :top

  def initialize
    @stack = Array.new
    self.top = nil
    @index = -1
  end

  def push(item)
    @index += 1
    @stack[@index] = item
    self.top = item
  end

  def pop
    temp = @stack[@index]
    @index -= 1
    empty? ? self.top = nil : self.top = @stack[@index]
    temp
  end

  def empty?
    @index == -1
  end
end