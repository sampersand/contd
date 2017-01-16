require_relative '../operators_extend'
require_relative '../operator'

module Operators::Sub
  extend Operators

  OPERATOR = Operator.new :-, 0 

end