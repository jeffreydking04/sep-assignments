class GenericNode
  attr_accessor :parent
  attr_accessor :left
  attr_accessor :right
  attr_accessor :data

  def initialize(data)
    @data = data
    @parent = nil
    @left = nil
    @right = nil
  end
end