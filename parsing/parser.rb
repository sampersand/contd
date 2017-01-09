class Parser
  require_relative '../core/container'
  require_relative 'parser_api'

  def initialize(*commands, use_default: true)
    @commands = commands.collect{ |cmd| cmd.new(self) }
    @commands << DefaultParserAPI.new(self) if use_default
  end

  def parse(body)
    results = Container.new
    # body = parse_precommands(body, results)
    parse_body(body.each_char, results)
    results
  end

  def parse_body(iter, results)
    token = ''
    loop do
      args = [iter.next, token, results, iter]
      command_func(:start_comment, *args) ||
      command_func(:continue_comment, *args) ||
      command_func(:end_comment, *args) ||

      command_func(:start_container, *args) ||
      (command_func(:end_container, *args) and break) || 

      command_func(:start_token, *args) ||
      command_func(:continue_token, *args) ||
      command_func(:end_token, *args) || 

      fail(args.to_s)
    end
    
    raise token unless token.empty?
  end


  def command_func(meth, char, token, results, iter)
    res = @commands.any?{ |command| command.method(meth).call(char, token, results, iter) }
  end

end



