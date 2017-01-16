require_relative 'operators/add'
require_relative 'operators/sub'

module Operators
  OPERATORS = [Add, Sub]

  module_function
  def added(parser)
    OPERATORS.each{ |o| o.added(parser) }
  end

  def handle_next(parser)
    OPERATORS.any?{ |o| o.handle_next(parser) }
  end

end




















