require_relative '../../operators_extend'
require_relative '../../operator'

module Operators::Index
  module Known
    extend Operators

    OPERATOR = Operator.new( '.?', 5 ){ |args, current|
      attribute = args.pop
      object = args.pop
      current << object.known.fetch(attribute){ raise "Known not found `#{position}`" }
    }

  end
end
