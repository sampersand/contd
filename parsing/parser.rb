
class Parser
  require_relative '../core/container'
  require_relative 'parser_api'

  def initialize(**options)
    @keywords = options[:keywords] || {'!': Keyword::Get, '@': Keyword::Call }
  end

  def parse(body)
    results = Container.new
    # body = parse_precommands(body, results)
    parse_body(body.each_char, results)
  end

  def parse_body(iter, results)
    token = ''
    loop do
      case (token.concat iter.next)
      when comment?
        handle_comment(token, results, iter)
      when begin_container?
        handle_container(token, results, iter)
      when end_container?
        handle_token(token.chop!, results, iter)
        break
      else
        # do nothing, token is already concatinated
      end
    end
    handle_token(token, results, iter)
    raise token unless token.empty?
    results
  end

  private

  # comment handling
    def handle_comment(token, results, iter)
      handle_token(token.chop!, results, iter)
      comment = ''
      loop do 
        case (comment.concat iter.next)
        when end_comment? then break
        end
      end
      # comment to be used for pre-commands
    end

    def comment?
      %r(.*#$)
    end

    def end_comment?
      /\n$/
    end

  # container
    def handle_container(token, results, iter)
      handle_token(token.chop!, results, iter)
      results << parse_body(iter, results.class.new)
    end

    def begin_container?
      /[{(\[]/
    end

    def end_container?
      /[})\]]/
    end


  # token
    def handle_token(token, results, _)
      # take the large token and break it apart into smaller tokens. IE '1+x' --> ['1', '+', 'x']
      return if token.empty?
      break_apart_token(token, results).each{ |sym| process_single_sym(sym, results) }
    end

    def break_apart_token(token, results)
      # DANGEROUS. THIS IS WILL NOT WORK FOR MORE ABSTRACT STUFF
      whitespace = " \n\t".chars
      break_ons = "@!+-*/=^".chars + whitespace
      # this should split at whitespace and defined operators.
      res = [token]
      break_ons.each do |sym_to_break_on| 
        res.collect! do |e|
          e.partition(sym_to_break_on) # WILL FAIL!
          # 'a+b+c'.partition(/+/) --> ['a', '+', 'b+c']
        end.flatten!.delete_if(&:empty?)
      end
      res.reject!(&whitespace.method(:include?)).collect!(&:to_sym)
      token.clear
      res
    end

    def process_single_sym(sym, results)
      results << if is_sym_a_keyword? sym
                   get_keyword(sym)
                 else
                   get_identifier(sym)
                 end
    end

      def is_sym_a_keyword?(sym)
        @keywords.include?(sym)
      end

      def get_keyword(sym)
        @keywords[sym].new
      end

      def get_identifier(sym)
        sym
      end
end





parser = Parser.new


body, args = parser.parse('''#
#! Inlcude Add Sub
#! Number
+! @ (33 4)
''')
puts '----'
p body, args
puts '----'
exit

results = Container.new
body.call(args: args, results: results)
puts results




















