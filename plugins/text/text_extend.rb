module Text
  module ExtendedMethods

    def handle_next(parser:, result:)
      fail "this only works for quotes and esapes of len 1" unless self::QUOTE.length == 1 &&
                                                                   self::ESCAPE.length == 1
      return unless parser.peek == self::QUOTE

      start_quote = parser.next
      end_quote = start_quote
      body = ''

      until (body += parser.next)[-1] == end_quote
        
        if body[-1] == self::ESCAPE
          case parser.peek
          when self::NEWLINE then parser.next #and ignore
          else body += parser.next
          end
        end
      end
      result << body[0, body.length - 1]
      # result << start_quote + body
      true
    rescue parser.class::EOFError => e
      raise parser.class::EOFError,
            "Reached end of stream whilst looking for end of text (`#{self::QUOTE.inspect}`)"
    end
  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end
