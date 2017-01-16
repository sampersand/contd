require_relative '../operators_extend'
require_relative '../operator'

module Operators::Pow
  extend Operators

  OPERATOR = Operator.new :**

end