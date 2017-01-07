class Container

  # ----- Attributes ----- #
  attr_reader :stack
  attr_reader :knowns

  # ----- Class Methods ----- #
  def self.from(body)
    container = new
    body.each do |token|
      case token
      when Keyword
        #...
      else 
        container << token
      end
    end
    p container
    container
  end


  # ----- Initializer ----- #
  def initialize(stack: [], knowns: {})
    @stack  = stack
    @knowns = knowns
  end


  # ----- Accessors ----- #
  def <<(obj)
    @stack << obj
  end

  def []=(key, obj)
    @knowns[key] = obj
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

def id(val) Identifier.new( val ) end
body = [
  :+,
  [
    id(1),
    id(2),
  ],
  Keyword::Call.new
]
new_body = Container::from body


require 'ap'
ap new_body, index: false

