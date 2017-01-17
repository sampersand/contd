module Operators
  module ExtendedMethods
    # def added(parser)
    #   parser.result[self::OPERATOR.name] = self::OPERATOR
    # end


    def priority(parser, token)
      token = parser.result.known[token] if parser.result.known.include? token
      token.respond_to?(:priority) ? token.priority : 0
    end

    def next_token(parser, token)
      res = ''
      until parser.empty?
        p parser
        p token
        exit if parser.peek == ';'
        if priority(parser, token) >= priority(parser, parser.peek)
          res << parser.next
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

      
      parser.fork(next_token(parser, parser.next)).run.stack.each(&res.method(:<<))
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