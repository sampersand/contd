require_relative 'number/int'
require_relative 'number/decimal'

module Number

  module_function

  def process_stream(**kwargs)
    Decimal.process_stream(**kwargs) ||
    Int.process_stream(**kwargs)
  end

end