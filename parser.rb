
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
    parse_tokens(tokens.stack.each)
  end

  private

  def tokenize_handle_result(result) # TODO: MAKE THIS WORK WITH 1+2
    ind = /\s/ =~ result.last
    return unless ind
    token = result.pop[0, ind]
    result << Identifier.new( token ) unless token.empty?
    result << ''
  end

  def tokenize(body)
    result = Container.new(stack: [''])
    body = body.each_char
    loop do
      result.last += body.next
      split = tokenize_handle_result(result)
    end
    result.pop if result.last.empty?
    result << Identifier.new( result.pop ) unless result.last.is_a?( Identifier )
    fail unless result.stack.each{ |e| e.is_a?( Identifier ) && e.token.is_a?(String) }
    result
  end

  def parse_tokens(tokens)
    stack = Container.new
    opers = Container.new
    loop do 
      case(token = tokens.next)
      when operator? then 0
      when left_paren? then stack << parse_tokens(tokens)
      when right_paren? then break
      when keyword? then stack << create_keyword(token)
      else stack << token
      end
    end
    stack
  end

  def operator?
    lambda do |t|
      nil
    end
  end

  def right_paren?
    lambda do |t|
      /[)}\]]/ =~ t.token
    end
  end

  def left_paren?
    lambda do |t|
      /[({\[]/ =~ t.token
    end
  end

  def keyword?
    lambda do |t|
      nil
    end
  end

end








parser = Parser.new
body = parser.parse(File.read('code.rb'))
p body.stack

