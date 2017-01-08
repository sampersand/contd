class Container

  # ----- Attributes ----- #
  attr_reader :stack
  attr_reader :locals
  attr_reader :globals

  # ----- Initializer ----- #
  def initialize(stack: nil, locals: nil, globals: nil)
    @stack  = stack || []
    @locals = locals || {}
    @globals = globals || {}
    fail unless @stack.respond_to?(:each)
    fail unless @stack.respond_to?(:pop)
    fail unless @stack.respond_to?(:push)
    fail unless @locals.respond_to?(:[])
    fail unless @locals.respond_to?(:[]=)
    fail unless @globals.respond_to?(:[])
    fail unless @globals.respond_to?(:[]=)

  end


  # ----- Indexing ----- #
  def [](val)
    @locals[val] || @globals[val]
  end
  def <<(val)
    @stack << val
  end
  def pop
    @stack.pop
  end

  # ----- Execution ----- #
  def call(result)
    # result = Container.new       # DANGEROUS?
    # result.locals.update(locals) # DANGEROUS?

    @stack.each do |token|
      case token
      when Keyword::Get
        key = result.pop
        val = self[key]
        raise NameError, "Unknown token: #{key.inspect}" unless val
        result << val
      when Keyword::Call
        args = result.pop
        func = result.pop
        args = args.(result)  # DANGEROUS
        func.(args, result) # UNKNOWN IF THIS WORKS
      else
        fail "TODO: Keyeword #{token}" if token.is_a?(Keyword)
        result << token
      end
    end
    result
  end

  def execute(args)
    result = self.class.new(globals: @globals.clone

                            )
    puts result
    #something funky might go on here with locals
    exit
    merge_globals(args).call!
  end

  # ----- Representation ----- #
  def to_s
    "(#{stack_str}, #{locals_str}, #{globals_str})"
  end

  def inspect
    "#{self.class}#{to_s}"
  end

  def stack_str
    "[#{@stack.join(', ')}]"
  end
  def globals_str
    globalz = globals.reject{ |_, v| v.is_a?(Proc)}
    "{#{globalz.collect{|k, v| "#{k}: #{v}"}.join(', ')}}"
  end

  def locals_str
    "{#{@locals.collect{|k, v| "#{k}: #{v}"}.join(', ')}}"
  end
end


if __FILE__ == $0
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

  args = Container.new(
    locals:
      {
        Identifier.new( :x ) => Identifier.new(3),
      },
    globals:
      {
        Identifier.new( :+ ) => proc{ |args, result|
          right = args.stack.pop
          left = args.stack.pop
          result.stack << left.class.new(left.token + right.token)
        },
      }
  )

  result = body.call(args)

  p result
end






















 























