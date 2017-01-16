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
    args = current.pop
    right, left = args.pop, args.pop
    current << left.method(@name).(right)
  end

end