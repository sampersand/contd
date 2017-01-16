require_relative 'operators/add'
require_relative 'operators/neg'

module Operators
  OPERATORS = [Add, Neg]

  module_function
  def added(parser)
    OPERATORS.each{ |o| o.added(parser) }
  end

  def handle_next(parser)
    OPERATORS.any?{ |o| o.handle_next(parser) }
  end

end




















