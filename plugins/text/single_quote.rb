module Text
  module SingleQuote
    
    module_function

    QUOTE = '\''
    ESCAPE = '\\'

    def process_stream(stream:, result:, **_)
      return unless stream.peek == QUOTE
      start_quote = stream.next
      quote = start_quote # pop the starting quote
      loop do
        quote += stream.next
        case quote[-1]
        when ESCAPE
          quote += stream.next
        when start_quote
          break
        end
      end
      result << quote
      true
    end

  end
end
