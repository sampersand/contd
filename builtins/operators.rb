module Operators
  class Operator
    def initialize(name, &func)
      @name = name
      @func = func
    end

    def to_s
      @name.to_s
    end

    def call(results)
      @func.call(results)
    end
    def awesome_inspect(options)
      self
    end
    def inspect
      "#{self.class}( #{@name} )"
    end
  end

  class BinaryMethodOperator < Operator
    def call(results)
      new_knowns = results.clone_knowns
      results.pop.call(new_knowns)
      results << new_knowns.stack.reduce(&@name)
    end
  end

  class UnaryMethodOperator < Operator
    def call(results)
      results << results.pop.method(@name).()
    end
  end


  Assign = Operator.new(:'='){ |results|
    args = results.pop.stack
    fail(args.length.to_s) unless args.length == 2
    results[args[0]]=args[1]
  }
  
  Pos    = BinaryMethodOperator.new :-@
  Neg    = BinaryMethodOperator.new :+@
  Invert = BinaryMethodOperator.new :~

  Add    = BinaryMethodOperator.new :+
  Sub    = BinaryMethodOperator.new :-
  Mul    = BinaryMethodOperator.new :*
  Div    = BinaryMethodOperator.new :/
  Pow    = BinaryMethodOperator.new :**

  LShift = BinaryMethodOperator.new :<<
  RShift = BinaryMethodOperator.new :>>
  Or     = BinaryMethodOperator.new :|
  And    = BinaryMethodOperator.new :&
  Xor    = BinaryMethodOperator.new :'^'

  Equal        = BinaryMethodOperator.new :==
  NotEqual     = BinaryMethodOperator.new :!=
  Less         = BinaryMethodOperator.new :<
  Greater      = BinaryMethodOperator.new :>
  LessEqual    = BinaryMethodOperator.new :<=
  GreaterEqual = BinaryMethodOperator.new :>=
  Compare      = BinaryMethodOperator.new :<=>

end














