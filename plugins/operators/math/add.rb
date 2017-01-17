require_relative '../operators_extend'
require_relative '../operator'

module Operators::Add
  extend Operators

  OPERATOR = Operator.new '+', priority: 12

end