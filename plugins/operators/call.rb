require_relative 'operators_extend'
require_relative 'operator'

module Operators::Call
  extend Operators

  OPERATOR = Operator.new( '@', 13 ){ |args, current|
    exit
    p args
    current << args.pop #func args
    current << args.pop #function
    current << Keyword::Call.new
  }

end
