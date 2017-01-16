require_relative 'operators/add'

module Operators

  module_function

  def added(parser:)
    Add.added(parser: parser)
  end

  def handle_next(**kwargs)
    Add.handle_next(**kwargs)

  end

end




















