require_relative '../operators_extend'
require_relative '../operator'

module Operators::Mod
  extend Operators

  OPERATOR = Operator.new :%

end