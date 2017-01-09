class Parser
  require_relative '../core/container'
  require_relative 'pre_command'

  def initialize(**options)
    @whitespace = /\s/ || options[:whitespace]
    @parens = /[(){}\[\]]/ || options[:parens]
    @keywords = {'!': Keyword::Get, '@': Keyword::Call} || options[:keywords]
  end

  def parse(body)
    results = Container.new
    # body = parse_precommands(body, results)
    parse_body(body, results)
    results
  end

  private

  def parse_precommands(body, results)
    body.each_line.collect do |line|
      if is_precommand? line
        # split_precommand(line).call(self, results)
      else
        line
      end
    end.compact.join
  end
    def precommand_prefix
      '#! '
    end

    def is_precommand?(text)
      text.start_with? precommand_prefix
    end

    # def split_precommand(text)
    #   text.gsub(precommand_prefix, '').strip.split(/ /)
    # end

    # def process_precommand(cmd, *args)
    #   puts "TODO: process_precommand(#{cmd}, *#{args})"
    # end

  def parse_body(body, results)
    token = ''
    body.each_char do |char|
      args = {char: char, token: token, results: results}
      case
      when start_token?(**args)
        token = char
      when continue_token?(**args)
        token += char
      when end_token?(**args)
        results << parse_token(token: token, results: results) if append_token?(token: token, results: results)
        token.clear
      else fail "No known way to deal with: char: `#{char}`, token: `#{token}`, results: `#{results}`"
      end
    end
    results << parse_token(token: token, results: results) unless token.empty?
  end
    def start_token?(char:, token:, results:)
      return false unless token.empty?
      case char
      when @whitespace then false
      else true
      end
    end

    def continue_token?(char:, token:, results:)
      case char
      when @whitespace, @parens, @keywords then false
      else true
      end
    end

    def end_token?(char:, token:, results:)
      case char
      when @whitespace, @parens, @keywords then true
      else false
      end
    end
    def append_token?(token:, results:)
      true
    end
    def parse_token(token:, results:)
      case token
      when @keyword then parse_keyword( token )
      else parse_identifier( token )
      end
    end
      def parse_keyword(token)
        @keywords[token].new
      end
      def parse_identifier(token)
        token
      end
end



parser = Parser.new

body, args = parser.parse('''
#! Inlcude Add Sub
#! Number
+! @ (3 4)
''')
puts '----'
p body, args
puts '----'
exit

results = Container.new
body.call(args: args, results: results)
puts results



