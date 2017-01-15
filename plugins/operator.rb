require_relative 'operator/add'

module Operator

  module_function

  def on_added(parser)
    Add.on_added(parser)
  end

  def process_stream(**kwargs)
    Add.process_stream(**kwargs)

  end

end




















