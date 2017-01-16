class Operator
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    @name.to_s
  end

  def inspect
    "#{self.class}( `#{@name.inspect}` )"
  end

  def call(current)
    arg_container = current.pop.call(current.clone)
    current << arg_container.stack.reduce(&@name)
  end

end