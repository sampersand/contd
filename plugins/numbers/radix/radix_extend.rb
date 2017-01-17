module Numbers
  module Radix
    module ExtendedMethods
      def handle_next(parser:, result:)

        return unless self::START_REGEX =~ parser.peek(self::START_REGEX.source.length)
        parser.next(self::START_REGEX.source.length) # pop the start of the regex
        res = parser.next_while(&self::BODY_REGEX.method(:=~))
        result << res.to_i(self::BASE)
        true

      end
    end

    module_function

    def extended(other)
      other.extend ExtendedMethods
    end

  end
end