require_relative 'functions_extended'
require_relative 'function'

module Functions::If
  extend Functions

  FUNCTION = Function.new( 'if' ){ |args, current|

    if_false = args.stack.length == 3 ? args.pop : nil
    if_true = args.pop
    condition = args.pop

    if condition
      if_true
    elsif if_false
      if_false
    else
    end

  }
  def self.handle_next(parser:, result:)
    return unless parser.peek(self::FUNCTION.name.length) == self::FUNCTION.name.to_s
    # result << parser.next(self::FUNCTION.name.length)
    # result[self::FUNCTION.name] = self::FUNCTION
    parser.next(self::FUNCTION.name.length) # pop the name
    args = Container.new
    parser.handle_next(result: args) until args.stack.length == 2
    p parser.peek_handle_next(result: Container.new)

    exit
    result << args
    result << self::FUNCTION
    result << Keyword::Call.new
    parser.feed(':', '(', ')')
    :retry
  end
  
end


















