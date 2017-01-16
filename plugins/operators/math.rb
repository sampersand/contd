require_relative 'math/add'
require_relative 'math/sub'
require_relative 'math/mul'
require_relative 'math/div'
require_relative 'math/mod'
require_relative 'math/pow'

module Operators
  module Math
    OPERATORS = [Add, Sub, Mul, Div, Mod, Pow]

    module_function
    def added(parser)
      OPERATORS.each{ |o| o.added(parser) }
    end

    def handle_next(parser)
      OPERATORS.any?{ |o| o.handle_next(parser) }
    end
  end
end