require_relative '../operators_extend'
require_relative '../operator'

module Operators::Greater
  extend Operators

  OPERATOR = Operator.new '>', priority: 20
  
end