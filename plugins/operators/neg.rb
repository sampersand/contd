require_relative 'operators_extend'
require_relative 'operator'

module Operators::Neg
  extend Operators

  OPERATOR = Operator.new( :-@ )

end