require_relative '../../operators_extend'
require_relative '../../operator'

module Operators::Index
  module Both
    extend Operators

    OPERATOR = Operator.new( '.', 5 ){ |args, current|
      attribute = args.pop
      object = args.pop
      result = object.known[attribute] || object.stack[attribute]

      raise "Attribute not found `#{attribute}`" unless result
      result
    }

  end
end
