require_relative '../../operators_extend'
require_relative '../../operator'
require_relative '../call'

module Operators::Index
  module CallIndexFirstEle
    extend Operators

    OPERATOR = Operator.new( ':', 6 ){ |args, current|
      attribute = args.pop
      object = args.pop
      result = object.known[attribute] || object.stack[attribute]

      raise "Attribute not found `#{attribute}`" unless result
      result
    }

  end
end
