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
    puts current, self
    exit
  end

end