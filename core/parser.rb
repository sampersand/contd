require_relative 'container'

class Parser
  EOFError = Class.new( SyntaxError )
  module DefaultPlugin
    module_function
    def handle_next( parser )
      parser.result << parser.next
    end
  end

  attr_reader :plugins
  attr_reader :result

  def initialize(input, plugins: nil, result: nil)
    @chars = input.chars
    @plugins = plugins || [DefaultPlugin]
    @result = result || Container.new
  end

  # --- Parsing --- #
  def add(plugin)
    @plugins.unshift plugin
    plugin.added(self) if plugin.respond_to?(:added)
  end

  def run
    handle_next until empty?
    @result
  end

  def handle_next
    @plugins.each do |plugin|
      res = plugin.handle_next( self )
      return res if res
    end
  end

  def fork(input)
    self.class.new(input, plugins: @plugins.clone)
  end

  # --- Stream --- #
  def next(amnt=1)
    @chars.empty? and fail(EOFError, "Reached end of stream!")
    @chars.shift(amnt).join
  end

  def feed(*vals)
    @chars.unshift *vals
  end

  def empty?
    @chars.empty?
  end

  def peek(amnt=1)
    @chars.first(amnt).join
  end

  def to_a
    @chars.clone
  end

  def next_while(&block)
    res = []
    res << self.next while block.call(self.peek)
    res.join
  end
  
  # --- Representaiton --- #
  def to_s
    @chars.to_s
  end

end

