require_relative 'container'
require_relative 'char_stream'

class Parser

  module DefaultPlugin
    module_function
    def process_stream(stream:, result:, **_)
      result << stream.next
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
    stream = CharStream::from_str input
    until stream.empty?
      process_stream(stream: stream, result: result)
    end
    result
  end

  private

  def process_stream(stream:, result:)
    @plugins.each do |plugin|
      res = plugin.process_stream(result: result, stream: stream, parser: self)
      return res if res
    end

  end

end












