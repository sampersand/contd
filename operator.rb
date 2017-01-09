class Operator
  def initialize(name, &func)
    @name = name
    @func = func
  end

  def to_s
    "#{@name}"
  end

  def inspect
    "#{self.class}( #{@name} )"
  end

  def call(results)
    @func.call(results)
  end

end

Operator::Add = Operator.new(:+){ |results| results.pop + results.pop }