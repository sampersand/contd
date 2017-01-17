require_relative '../operators_extend'
require_relative '../operator'

module Operators::Div
  extend Operators

  OPERATOR = Operator.new '/', priority: 11

end