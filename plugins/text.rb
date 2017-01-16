require_relative 'text/single_quote'
require_relative 'text/double_quote'

module Text

  module_function

  def handle_next(**kwargs)
    SingleQuote.handle_next(**kwargs) ||
    DoubleQuote.handle_next(**kwargs)
  end

end