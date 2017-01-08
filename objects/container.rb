class Container

  # ----- Attributes ----- #
  attr_reader :stack
  attr_reader :knowns

  # ----- Initializer ----- #
  def initialize(stack: [], knowns: {})
    @stack  = stack
    @knowns = knowns
    fail unless stack.respond_to?(:each)
    fail unless stack.respond_to?(:pop)
    fail unless stack.respond_to?(:push)
    fail unless knowns.respond_to?(:[])
    fail unless knowns.respond_to?(:[]=)
  end


  # ----- merging ----- #
  
  def merge_knowns(other)
    # possibly dangerous with the cloning fun stuff :P
    self.class.new(stack: @stack,
                   knowns: @knowns.clone.update(other.knowns))
  end

  # ----- Execution ----- #
  def call!
    result = self.class.new #somehow use knowns here
    @stack.each do |token|
      case token
      when Keyword::Get
        key = result.stack.pop
        val = knowns[key]
        raise NameError, "Unknown token: #{key.inspect}" unless val
        result.stack << val
      when Keyword::Call
        args = result.stack.pop
        func = result.stack.pop
        func.call(args, result)
      else
        fail "TODO: Keyeword #{token}" if token.is_a?(Keyword)
        result.stack << token
      end
    end
    result
  end

  def call(args)
    merge_knowns(args).call!
  end

  # ----- Representation ----- #
  def to_s
    return "()" if @stack.empty? && @knowns.empty?
    return knowns_str if @stack.empty?
    return stack_str if @knowns.empty?
    "(#{stack_str}, #{knowns_str})"
  end

  def inspect
    "#{self.class}#{to_s}"
  end

  def stack_str
    "[#{@stack.join(', ')}]"
  end

  def knowns_str
    "{#{@knowns.collect{|k, v| "#{k}: #{v}"}.join(', ')}}"
  end

  def ai(options)
    awesome_inspect(options).ai(options)
  end

  def awesome_inspect(options)
    @stack.collect{ |ele| ele.awesome_inspect(options) }
  end

end



require_relative 'keyword'
require_relative 'identifier'
body = Container.new(stack: [
  Identifier.new( :+ ),
  Keyword::Get.new,
  Container.new(stack: [
    Identifier.new( :x ),
    Keyword::Get.new,
    Identifier.new(  2 ),
  ]),
  Keyword::Call.new
])

args = Container.new(knowns: {
  Identifier.new( :x ) => Identifier.new(3),
  Identifier.new( :+ ) => proc{},
})

result = body.call(args)

require 'ap'
ap result, index: false

















