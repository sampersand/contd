require_relative '../../operators_extend'
require_relative '../../operator'

module Operators::Index
  module Stack
    extend Operators

    OPERATOR = Operator.new( '.$', 6 ){ |args, current|
      position = args.pop
      object = args.pop
      object.stack[position] or raise "Stack position not found `#{position}`"
    }

  end
end
