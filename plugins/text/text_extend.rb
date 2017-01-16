module Text
  module ExtendedMethods

    def handle_next(stream:, result:, **_)
      fail "this only works for quotes and esapes of len 1" unless self::QUOTE.length == 1 &&
                                                                   self::ESCAPE.length == 1
      return unless stream.peek == self::QUOTE

      start_quote = stream.next
      end_quote = start_quote
      body = ''

      until (body += stream.next)[-1] == end_quote
        
        if body[-1] == self::ESCAPE
          case stream.peek
          when self::NEWLINE then stream.next #and ignore
          else body += stream.next
          end
        end
      end
      result << start_quote + body
      true
    rescue stream.class::EOFError => e
      raise stream.class::EOFError,
            "Reached end of stream whilst looking for end of text (`#{self::QUOTE.inspect}`)"
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end
