require_relative 'operators_extend'
require_relative 'operator'

module Operators::Call
  extend Operators

  OPERATOR = Operator.new( '@', 13 )

  module_function

end
