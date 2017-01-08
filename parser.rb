
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
    result << Identifier.new( result.pop )
    fail unless result.stack.each{ |e| e.is_a?( Identifier ) }
    result
  end

  def parse_tokens(tokens)
    stack = Container.new
    opers = Container.new
    p tokens.stack
    exit
    # until tokens.empty?
    #   case (token = tokens.shift)
    #   when options[:operator]
    #   when options[:parenthesis]
    #   when options[:keyword]
    #     stack << create_keyword(token, options)
    #   else
    #     stack << create_identifier(token, options)
    #   end
    # end
    # stack << opers.pop until opers.empty?
    # stack
  end


end









parser = Parser.new
body, args = parser.parse(File.read('code.rb'))

