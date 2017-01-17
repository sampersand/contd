module Operators
  module ExtendedMethods
    # def added(parser)
    #   parser.result[self::OPERATOR.name] = self::OPERATOR
    # end


    def priority(token)
      case token
      when '=' then 20
      when '^' then 10
      when '*' then 11
      when '@' then 11
      when '%' then 11
      when '+' then 12
      when '-' then 12
      when '@' then 5
      else 0
      end
    end

    def next_token(parser, token, result)
      until parser.empty?
        peeked = parser.peek_handle_next(result: result).stack.last
        p "peekeD: " + peeked.to_s, result.to_s
        if priority(token) >= priority(peeked)
          parser.handle_next(result: result)
        else
          break
        end
      end
    end

    def handle_next(parser:, result:)
      return unless parser.peek(self::OPERATOR.name.length) == self::OPERATOR.name.to_s

      to_add = Container.new

      next_token(parser, parser.next(self::OPERATOR.name.length), to_add)
      result << to_add
      result << self::OPERATOR
      result << Keyword::Call.new

    rescue parser.class::EOFError => e
      raise parser.class::EOFError,
            "Reached end of stream whilst looking for rhs of function (`#{self::OPERATOR}`)"
    end


  end

  module_function

  def extended(other)
    other.extend ExtendedMethods
  end

end