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

    def next_token(parser, token)
      res = []
      until parser.empty?
        peeked = parser.peek_handle_next.result.stack.last
        if priority(token) >= priority(peeked)
          p "token: #{token}, #{peeked}, #{priority(token)} > #{priority(parser.peek)}"
          res << parser.handle_next.result.pop
        else
          break
        end
      end
      res
    end

    def handle_next(parser)
      return unless parser.peek(self::OPERATOR.name.length) == self::OPERATOR.name.to_s

      res = Container.new
      res << parser.result.pop
      
      next_token(parser, parser.next).each(&res.method(:<<))
      parser.result << res
      parser.result << self::OPERATOR
      parser.result << Keyword::Call.new

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