require_relative '../operators_extend'
require_relative '../operator'

module Operators::Pow
  extend Operators

  OPERATOR = Operator.new( '^', 10 ){ |args, current|
    pow = args.pop
    base = args.pop
    current << base ** pow
  }

end