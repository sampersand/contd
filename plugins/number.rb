require_relative 'number/whole'
require_relative 'number/decimal'

module Number

  module_function

  def process_stream(**kwargs)
    Decimal.process_stream(**kwargs) ||
    Whole.process_stream(**kwargs)
  end

end