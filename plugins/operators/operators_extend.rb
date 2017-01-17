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
      100.times do 
      end
      parser.result
      # res = ''
      # until parser.empty?
      #   pc = parser.clone
      #   pc.handle_next
      #   if priority(parser, token) >= priority(parser, pc.result.pop)
      #     parser.handle_next
      #     p parser.result, parser
      #     res << parser.result.pop
      #   else
      #     break
      #   end
      # end
      # res
    end

    def handle_next(parser)
      return unless parser.peek(self::OPERATOR.name.length) == self::OPERATOR.name.to_s

      res = Container.new
      res << parser.result.pop

      
      next_token(parser, parser.next).stack.each(&res.method(:<<))
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