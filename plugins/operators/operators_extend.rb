module Operators
  module ExtendedMethods
    def added(parser:)
      parser.result[self::OPERATOR.name] = self::OPERATOR
    end



    def process_stream(stream:, result:, parser:, **_)
      return unless stream.peek == self::OPERATOR.name
    end


  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end