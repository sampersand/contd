class Parser
  require_relative 'container'
  require_relative 'keyword'
  require_relative 'pre_command'

  def parse(body)
    imported  = Container.new
    char_iter = body.each_char
    body      = parse_includes_and_comments(char_iter, imported)

    token_iter = get_token_iter(body)
    results     = parse_tokens(token_iter)

    [results, imported]
  end

  private

  def get_token_iter(body)
    body.split(/([\W])/).reject(&:empty?).each
  end

  def parse_includes_and_comments(char_iter, results)
    parsed_body = ''
    loop do 
      if is_comment?(char = char_iter.next)
        line = ''
        line += char_iter.next until is_end_comment?(line)
        handle_precommand(line, results)
      else
        parsed_body += char
      end
    end
    parsed_body
  end

    def is_comment?(char)
      char == '#'
    end

    def is_end_comment?(line)
      line[-1] == "\n"
    end

    def handle_precommand(line, results)
      
      PreCommand::from(line).call(results)
    end

  def parse_tokens(body)
    results = Container.new
    loop do
      case (token = body.next)
      when left_paren? #ignore
        results << parse_tokens(body)
      when right_paren?
        break
      when whitespace? #ignore
      else 
        results << instantiate_token(token)
      end
    end
    results
  end
    def whitespace?; /\s/ end
    def left_paren?; /[({\[]/ end
    def right_paren?; /[)}\]]/ end

    def instantiate_token(token)
      case token
      when call_keyword then Keyword::Call.new#( token )
      when get_keyword  then Keyword::Get.new#( token )
      else Identifier.new( token.to_sym )
      end
    end
      def call_keyword; /@/ end
      def get_keyword; /!/ end
end


















