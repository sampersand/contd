module Text
  module DoubleQuote
    
    module_function

    QUOTE = '\"'
    ESCAPE = '\\'

    def process_stream(stream:, result:, **_)
      return unless stream.peek == QUOTE
      res = ''
      loop do
        res += case stream.peek
                  when ESCAPE
                    stream.next + stream.next
                  when QUOTE
                    break
                  else
                    stream.next
                  end
      end
      result << QUOTE + res + QUOTE
    end

  end
end
