class Parser
  require_relative 'container'
  require_relative 'char_stream'

  module DefaultPlugin
    module_function
    def next_token(stream:, **_)
      stream.next
    end
    def handle_token(token:, result:, **_)
      result << token
    end
  end

  attr_reader :plugins

  def initialize(*plugins)
    @plugins = plugins + [DefaultPlugin]
  end

  def add(plugin)
    if plugin.respond_to?(:add_to_parser)
      plugin.add_to_parser(parser: self)
    else
      @plugins.unshift plugin
    end
  end

  def parse(input)
    result = Container.new
    stream = CharStream.new input
    until stream.empty?
      token = next_token(stream: stream,
                         result: result)
      handle_token(token: token,
                   result: result,
                   stream: stream)
    end
    result
  end

  private

  def handle_token(token:, result:, stream:)
    @plugins.each do |plugin|
      res = plugin.handle_token(token:  token,
                                result: result,
                                stream: stream,
                                parser: self)
      return res if res
    end
  end

  def next_token(stream:, result:)
    @plugins.each do |plugin|
      res = plugin.next_token(result: result,
                              stream: stream,
                              parser: self)
      return res if res
    end

  end

end












