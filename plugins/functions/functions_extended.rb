module Functions
  module ExtendedMethods
    def handle_next(parser:, result:)
      return unless parser.peek(self::FUNCTION.name.length) == self::FUNCTION.name.to_s
      
      parser.next(self::FUNCTION.name.length) # to pop it 

      result << self::FUNCTION
      parser.feed('@') #todo update this
      true
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end