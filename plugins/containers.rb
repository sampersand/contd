require_relative 'containers/brackets'
require_relative 'containers/parens'
require_relative 'containers/braces'

module Containers

  module_function

  def process_stream(**kwargs)
    Brackets.process_stream(**kwargs) ||
    Parens.process_stream(**kwargs) ||
    Braces.process_stream(**kwargs)

  end

end




















