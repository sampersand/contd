module Number
  module Whole
    
    module_function

    WHOLE_REGEX = /\d/

    def process_stream(stream:, result:, **_)

      res = stream.next_while(&WHOLE_REGEX.method(:=~))
      res.empty? ? nil : result << res.to_i
    end

  end
end
