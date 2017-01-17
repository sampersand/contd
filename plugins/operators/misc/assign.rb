require_relative '../operators_extend'
require_relative '../operator'


module Operators::Assign
  extend Operators

  OPERATOR = Operator.new( '=', '<-', '->', priority: 100 ){ |args, current|
    current.[]=(*args.pop(2))
  }

end