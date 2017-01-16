require_relative 'container'
require_relative 'char_stream'

class Parser

  module DefaultPlugin
    module_function
    def process_stream(stream:, result:, **_)
      result << stream.next
    end
  end

  attr_reader :input
  attr_reader :plugins
  attr_reader :result

  def initialize(input)
    @input = input
    @plugins = [DefaultPlugin]
    @result = Container.new
  end

  def add(plugin)
    @plugins.unshift plugin
    plugin.added(parser: self) if plugin.respond_to?(:added)
  end

  def run
    stream = CharStream::from_str input
    until stream.empty?
      process_stream(stream: stream, result: @result)
    end
    @result
  end

  def process_stream(stream:, result:)
    @plugins.each do |plugin|
      res = plugin.process_stream(result: result, stream: stream, parser: self)
      return res if res
    end
  end

end












