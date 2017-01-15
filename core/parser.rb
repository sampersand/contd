class Parser
  require_relative 'container'

  module DefaultPlugin
    module_function
    def next_token(stream:, **_)
      stream.shift
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
    @plugins.unshift plugin
  end

  def parse(input)
    result = Container.new
    stream = input.chars
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












