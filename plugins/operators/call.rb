require_relative 'operators_extend'
require_relative 'operator'

module Operators::Call
  extend Operators

  OPERATOR = Operator.new( '@' ){ |args, current|
    f_args = args.pop
    func = args.pop
    p f_args
    p func.call(f_args, current)
    exit 2
  }


  module_function

end
