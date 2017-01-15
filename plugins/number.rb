require_relative 'number/int'
require_relative 'number/decimal'

module Number

  module_function

  def add_to_parser(parser: )
    parser.add Number::Int
    parser.add Number::Decimal
  end

end