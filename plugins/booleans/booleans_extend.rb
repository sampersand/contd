module Booleans
  module ExtendedMethods
    def handle_next(parser:, result:)
      return unless parser.peek(self::VALUE.length) == self::VALUE
      result << case parser.next(self::VALUE.length).downcase
                when "true" then true
                when "false" then false
                when "null" then nil
                else raise " Unknown boolean! "
                end
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end

