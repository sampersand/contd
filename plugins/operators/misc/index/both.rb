require_relative '../../operators_extend'
require_relative '../../operator'

module Operators::Index
  module Both
    extend Operators

    OPERATOR = Operator.new( '.', 5 ){ |args, current|
      attribute = args.pop
      object = args.pop
      raise "Attribute not found `#{attribute}`" unless object.known.fetch(attribute, false) ||
                                                        object.stack.fetch(attribute, false)
      object.known.fetch(attribute) || object.fetch(attribute)
    }

  end
end
