module Numbers
  module Whole
    module_function

    WHOLE_REGEX = /\d/

    def handle_next(parser)
      (res = parser.next_while(&self::WHOLE_REGEX.method(:=~))).empty? and return
      parser.result << res.to_i
      true
    end

  end
end
