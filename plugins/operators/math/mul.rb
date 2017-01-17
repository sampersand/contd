require_relative '../operators_extend'
require_relative '../operator'

module Operators::Mul
  extend Operators

  OPERATOR = Operator.new '*'

end