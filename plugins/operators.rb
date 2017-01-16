require_relative 'operators/add'

module Operators

  module_function

  def added(parser)
    Add.added(parser)
  end

  def handle_next(parser)
    Add.handle_next(parser)

  end

end




















