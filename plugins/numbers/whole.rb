module Numbers
  module Whole

    WHOLE_REGEX = /\d/

    module_function

    def handle_next(parser:, result:)
      (res = parser.next_while(&self::WHOLE_REGEX.method(:=~))).empty? and return
      result << res.to_i
      true
    end

  end
end
