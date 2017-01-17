module Functions
  module ExtendedMethods
    def handle_next(parser:, result:)
      return unless parser.peek(self::FUNCTION.name.length) == self::FUNCTION.name.to_s
      # result << parser.next(self::FUNCTION.name.length)
      # result[self::FUNCTION.name] = self::FUNCTION
      parser.next(self::FUNCTION.name.length) # pop the name
      args = Container.new
      parser.handle_next(result: args) until args.stack.length == self::ARG_LENGTH
      result << args
      result << self::FUNCTION
      result << Keyword::Call.new
      true
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end
