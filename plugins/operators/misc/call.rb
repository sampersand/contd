require_relative '../operators_extend'
require_relative '../operator'

module Operators::Call
  extend Operators

  OPERATOR = Operator.new( '@', 5 ){ |args, current|
    f_args = args.pop
    func = args.pop
    func.call(f_args, current)
  }

end
