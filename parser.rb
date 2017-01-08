
class Parser
  require_relative 'objects/keyword'
  require_relative 'objects/identifier'
  require_relative 'objects/container'
  require_relative 'builtins/operators'
  require_relative 'builtins/functions'

  def initialize(**options)
    @options = options
  end

  def parse(body)
    tokens = tokenize(body)
    parse_tokens(tokens)
  end

  private

  def tokenize_handle_result(result) # TODO: MAKE THIS WORK WITH 1+2
    ind = /\s/ =~ result.last
    return unless ind
    token = result.pop[0, ind]
    result << token unless token.empty?
    result << ''
  end

  def tokenize(body)
    result = Container.new(stack: [''])
    body = body.each_char
    loop do
      result.last += body.next

      if result.last[-1] == '#' #this right here is very hacky!
        nil until body.next == "\n"
        result.last = result.last[0, result.last.length - 1] 
      end

      split = tokenize_handle_result(result)
    end
    result.pop if result.last.empty?
    result
  end

  def parse_tokens(tokens)
    stack = Container.new
    opers = Container.new
    until tokens.stack.empty?
      token = tokens.shift
      stack << (operator(token, stack, opers) ||
                left_paren(token, tokens) || 
                (right_paren(token, tokens) && break) || 
                keyword(token) ||
                number(token) || 
                Identifier.new( token ) )
    end
    stack
  end

  def operator(token, stack, opers)
    /\+/ =~ token and Identifier.new( token )
  end

  def right_paren(token, tokens)
    /[)}\]]/ =~ token
  end

  def left_paren(token, tokens)
    return unless /[({\[]/ =~ token
    parse_tokens(tokens)
  end

  def keyword(token)
    case token
    when /!/ then Keyword::Get.new( token )
    when /@/ then Keyword::Call.new( token )
    else nil
    end
  end

  def number(token)
    return unless /\d+/ =~ token
    token.to_f
  end

end








parser = Parser.new
body = parser.parse(File.read('code.rb'))
args = Container.new
args.knowns[Identifier.new( '+' )] = Operators::Add
p body.stack
res = body.call(args)
p res











