require_relative '../../operators_extend'
require_relative '../../operator'

module Operators::Index
  module Both
    extend Operators

    OPERATOR = Operator.new( '.' ){ |args, current|
      attribute = args.pop
      object = args.pop
      result = object.known[attribute] || object.stack[attribute]

      raise "Attribute not found `#{attribute}`" unless result
      result
    }


    module_function
  end
end
