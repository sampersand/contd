module Number
  module Whole
    module_function

    WHOLE_REGEX = /\d/

    def process_stream(stream:, result:, **_)
      res = stream.next_while(&self::WHOLE_REGEX.method(:=~))
      return if res.empty?
      result << res.to_i
      true
    end

  end
end
