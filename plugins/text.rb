require_relative 'text/single_quote'
require_relative 'text/double_quote'

module Text

  module_function

  def handle_next(parser)
    SingleQuote.handle_next(parser) ||
    DoubleQuote.handle_next(parser)
  end

end