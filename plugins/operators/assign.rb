require_relative 'operators_extend'
require_relative 'operator'

module Operators::Assign
  extend Operators

  OPERATOR = Operator.new( :'=' ){ |l, r, current|
    current[l] = r
  }

end