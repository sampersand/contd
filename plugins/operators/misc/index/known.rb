require_relative '../../operators_extend'
require_relative '../../operator'

module Operators::Index
  module Known
    extend Operators

    OPERATOR = Operator.new( '.?' ){ |args, current|
      attribute = args.pop
      object = args.pop
      object.stack[attribute] or raise "Known attribute not found `#{attribute}`"
    }

  end
end
