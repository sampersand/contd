require_relative 'operators/math'
require_relative 'operators/assign'

module Operators
  OPERATORS = [Math, Assign]

  module_function
  def added(parser)
    OPERATORS.each{ |o| o.added(parser) }
  end

  def handle_next(parser)
    OPERATORS.any?{ |o| o.handle_next(parser) }
  end

end




















