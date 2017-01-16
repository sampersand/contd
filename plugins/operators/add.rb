require_relative 'operators_extend'
require_relative 'operator'

module Operators::Add
  extend Operators

  OPERATOR_CLASS = Operator.new(VALUE)

end