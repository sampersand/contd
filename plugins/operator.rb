require_relative 'operator/add'

module Operator

  module_function

  def on_added(parser)
    Operator::Add.on_added(parser)
  end

  def process_stream(**kwargs)
    Operator::Add.process_stream(**kwargs)

  end

end




















