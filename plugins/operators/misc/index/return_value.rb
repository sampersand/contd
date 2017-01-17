require_relative '../../operators_extend'
require_relative '../../operator'
require_relative '../call'
require_relative 'stack'

module Operators::Index
  module ReturnValue
    extend Operators

    OPERATOR = Operator.new( ':', 5 ){ |args, current|
      result = Operators::Call::OPERATOR.call(args, current, override_args: false)
      Stack::OPERATOR.call(result << -1, current, override_args: false)
      current.pop
    }

  end
end