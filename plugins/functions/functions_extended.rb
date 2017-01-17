module Functions
  module ExtendedMethods
    def handle_next(parser:, result:)
      return unless parser.peek(self::FUNCTION.name.length) == self::FUNCTION.name.to_s
      # result << parser.next(self::FUNCTION.name.length)
      # result[self::FUNCTION.name] = self::FUNCTION
      parser.next(self::FUNCTION.name.length) # pop the name
      result << self::FUNCTION
      parser.feed(':')
      true
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end