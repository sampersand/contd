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

  def call(args, results)
    @func.call(args, results)
  end

end

Operator::Add = Operator.new(:+){ |args, results|
  results << (args >> 2) + args.pop
}
Operator::Div = Operator.new(:/){ |args, results|
  results << (args >> 2) / args.pop
}

Operator::Assign = Operator.new(:'='){ |args, results|
  results << (results[args >> 2] = args.pop)
}




















