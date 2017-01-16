require_relative 'container'
require_relative 'char_stream'

class Parser
  module DefaultPlugin
    module_function
    def process_parser(parser)
      result << parser.stream.next
    end
  end

  attr_reader :stream
  attr_reader :plugins
  attr_reader :result

  def initialize(input)
    @stream = CharStream::from_str input
    @plugins = [DefaultPlugin]
    @result = Container.new
  end

  def add(plugin)
    @plugins.unshift plugin
    plugin.added(parser: self) if plugin.respond_to?(:added)
  end

  def run
    process_parser until @stream.empty?
    @result
  end

  def process_parser
    @plugins.each do |plugin|
      res = plugin.process_parser( self)
      return res if res
    end
  end

end



puts Parser.new('a').next








