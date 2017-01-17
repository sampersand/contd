module Operators
  module ExtendedMethods
    # def added(parser)
    #   parser.result[self::OPERATOR.name] = self::OPERATOR
    # end


    def priority(token)
      token.respond_to?(:priority) ? token.priority : 0
    end

    def next_token(parser, token, result)
      until parser.empty?
        peeked = parser.peek_handle_next(result: result.clone)
        if peeked.stack[-1].is_a?(Keyword::Call) || peeked.stack[-1].is_a?(Keyword::Get)
          peeked = peeked.stack[-2] # because we have containers
        else
          peeked = peeked.stack[-1]
        end
        if priority(token) > priority(peeked)
          result.stack.pop if result.stack[-1].is_a? Keyword::Comma
          parser.handle_next(result: result)
        else
          break
        end
      end
    end

    def add_last(result, to_add) #VERY VERY HACKY
      if result.stack[-1].is_a?(Keyword::Comma)
        result.pop
        add_last(result, to_add)
      elsif result.stack[-1].is_a?(Keyword::Call)
        result.pop(3).each(&to_add.method(:push))
      elsif result.stack[-1].is_a?(Keyword::Get)
        result.pop(2).each(&to_add.method(:push))
      else
        to_add << result.pop
      end
    end

    def handle_next(parser:, result:)
      return unless parser.peek(self::OPERATOR.name.length) == self::OPERATOR.name.to_s

      parser.next(self::OPERATOR.name.length) #pop this token
      to_add = Container.new # HACKY

      add_last(result, to_add)

      next_token(parser, self::OPERATOR, to_add)
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