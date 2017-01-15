require_relative 'text/single_quote'
require_relative 'text/double_quote'

module Text

  module_function

  def process_stream(**kwargs)
    SingleQuote.process_stream(**kwargs) ||
    DoubleQuote.process_stream(**kwargs)
  end

end