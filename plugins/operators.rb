require_relative 'operators/add'

module Operators

  module_function

  def added(parser:)
    Add.added(parser: parser)
  end

  def process_stream(**kwargs)
    Add.process_stream(**kwargs)

  end

end




















