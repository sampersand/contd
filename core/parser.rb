class Parser
  require_relative 'container'

  attr_reader :options
  def initialize(*options)
    @options = options
  end

  def option_method(sym, *a, &b)
    result = nil
    @options.each do |option|
      next unless option.respond_to?(sym)
      result = option.method(sym).call(*a, &b)
      break if result
    end
    result
  end

  def each_token(input, &block)
    option_method(:each_token, input, &block)
  end

  def parse(input)
    result = Container.new
    each_token(input) do |token|
      
    end
  end

end

require_relative '../std/options'
input = 'x = 3'


parser = Parser.new(Std::Options.new)
res = parser.parse(input)
p res






