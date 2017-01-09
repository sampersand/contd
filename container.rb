class Container

  attr_reader :stack, :knowns

  def initialize(stack: nil, knowns: nil)
    @stack = stack || []
    @knowns = knowns || {}
  end

  # ---- Other methods ---- #
  def merge(other)

    fail unless other.respond_to?(:stack)
    fail unless other.respond_to?(:knowns)

    self.class.new(stack:  @stack.clone.concat(other.stack),
                   knowns: @knowns.clone.update(other.knowns))
  end

  def to_s
    "#{self.class}( #{@stack}, #{@knowns} )"
  end

  def inspect #maybe change this later?
    "#{self.class}( #{@stack}, #{@knowns} )"
  end

  def clone
    self.class.new(stack: @stack.clone, knowns: @knowns.clone )
  end

  # ---- Array methods ---- #
  def each(&block)
    @stack.each(&block)
  end

  def empty?
    @stack.empty?
  end

  def <<(value)
    @stack << value
  end

  def pop
    self >> 1
  end

  def >>(pos)
    @stack.delete_at(-pos)
  end

  # ---- Hash methods ---- #
  def [](key)
    @knowns[key]
  end

  def []=(key, value)
    @knowns[key] = value
  end

  # ---- Function methods ---- #
  def call(results)
    raise 'How to deal with results with positionals?' unless results.empty?
    call!( results.clone )
  end

  def call!(results)
    itr = each
    loop do 
      case (token = itr.next)
      when Keyword::Get
        fail if results.empty?
        key   = results.pop
        value = results[key]
        raise NameError, "Undefined token `#{key}`" unless value
        results << value
      when Keyword::Call
        func = results.pop
        args = itr.next
        func.call(args, results) # I've decided that function results go on the stack always
      else
        results << token
      end
    end
    results
  end

end










if __FILE__ == $0
  require_relative 'keyword'
  require_relative 'operator'
  body = Container.new(stack: [ # foo! @ (1, 2)
    :eql,
    Keyword::Get.new,
    Keyword::Call.new,
    Container.new(stack: [:x, 2]),
  ])
  results = Container.new( knowns: { eql: Operator::Assign } )
  puts body.call(results)
end

















