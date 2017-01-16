require_relative 'containers/brackets'
require_relative 'containers/parens'
require_relative 'containers/braces'

module Containers

  module_function

  def handle_next(parser)
    Brackets.handle_next(parser) ||
    Parens.handle_next(parser) ||
    Braces.handle_next(parser)

  end

end




















