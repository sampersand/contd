require_relative 'operators_extend'
require_relative 'operator'

module Operators::Call
  extend Operators

  OPERATOR = Operator.new( '@', 13 )

  module_function

  def handle_next(parser)

    return unless parser.peek(self::OPERATOR.name.length) == self::OPERATOR.name.to_s

    res = Container.new
    res << parser.result.pop

    
    parser.
      fork(next_token(parser, parser.next)).
      run.
      stack.
      each(&res.method(:<<))
    parser.result << res.pop
    parser.result << res.pop
    parser.result << Keyword::Call.new
    # exit
    # parser.result << parser.next(self::OPERATOR.name.length).to_sym # temporary

  end


end
