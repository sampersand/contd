require_relative 'containers/brackets'
require_relative 'containers/parens'
require_relative 'containers/braces'

module Containers

  module_function

  def handle_next(**kwargs)
    Brackets.handle_next(**kwargs) ||
    Parens.handle_next(**kwargs) ||
    Braces.handle_next(**kwargs)

  end

end




















