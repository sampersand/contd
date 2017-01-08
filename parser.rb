
module Parser
  require_relative 'objects/keyword'
  require_relative 'objects/identifier'
  require_relative 'objects/container'
  require_relative 'builtins/operators'
  require_relative 'builtins/functions'

  module_function

  def handle_include(acc, knowns)
    func_name = acc[acc.index(' ')+1, acc.length].to_sym
    if Operators::AllOperators.include?(func_name)
      knowns.knowns[func_name] = Operators::AllOperators[func_name]
    elsif Functions::AllFunctions.include?(func_name)
      knowns.knowns[func_name] = Functions::AllFunctions[func_name]
    else
      raise "Unknown include `#{func_name}`"
    end
    # :+     => Operators::Add,
  end

  def tokenize(body, **options)

    res = ['']
    knowns = Container.new
    body = body.each_char.to_a

    until body.empty?
      c = body.shift
      case c
      when options[:left_paren], options[:right_paren],\
            options[:get_kw], options[:call_kw], options[:newl_kw],
            options[:infix_oper]
        res << c << ''
      when options[:whitespace], options[:linebreak]
        res << '' unless res.last.empty?
      when options[:comment]
        acc = c
        acc << body.shift until options[:linebreak] =~ body.first || body.empty?
        if (acc =~ options[:include]) == 0
          handle_include(acc, knowns)
        end
      else
        res[-1] += c
      end
    end
    [res.reject(&:empty?), knowns]
  end

  def parse_all(body, **options)


    options[:whitespace] ||= /[\s,]/
    options[:parens]  ||= /[(){}\[\]]/
    options[:comment] ||= /#/
    options[:include] ||= /#!INCLUDE/
    options[:linebreak] ||= /[;\n]/
    options[:newl_kw] ||= /;/
    options[:get_kw] ||= /[!]/
    options[:call_kw] ||= /[@]/
    options[:left_paren] ||= /[({\[]/
    options[:right_paren] ||= /[)}\]]/
    options[:infix_oper] ||= /(?x)
        \+|-|\*|\/|%|\*\*|
        &|\^|\||<<|>>|
        >|<|<=|>=|==|!=|<=>|
        =|\./
    options[:digit] ||= /[\d]+(?:\.\d+)?/


    tokens, knowns = tokenize(body, **options)
    res = parse(tokens, **options)

    [res, knowns]
  end

  def precedence(o)
    case o
    when :'.' then 5
    when :** then 4
    when :*, :%, :/ then 3
    when :+, :- then 2
    when :<, :>, :<=, :>=, :==, :'!=', :<=> then 1
    when :'=' then 0
    else raise "Unknown precedence for operator `#{o}`"
    end
  end

  def associativity(o)
    return :left unless o == :**
    :right
  end

  def parse(tokens, **options)

    # +-*/ ** % << >> & | ^ ~ 
    # +-*/ % & | ^

    stack = []
    oper_stack = []

      push_oper = proc{ stack << oper_stack.pop\
                              << Keyword::Get.new(:get)\
                              << Keyword::Call.new(:call) } #thrown together
    until tokens.empty? 
      t = tokens.shift.to_sym
      case t
      when options[:infix_oper]
        push_oper.() while !oper_stack.empty? &&(
            associativity(t) == :left && precedence(t) <= precedence(oper_stack.last) || 
            associativity(t) == :right && precedence(t) < precedence(oper_stack.last))
        oper_stack << t
      when options[:left_paren] then stack << parse(tokens, **options)
      when options[:right_paren] then break
      when options[:get_kw] then stack << Keyword::Get.new( t )
      when options[:call_kw] then stack << Keyword::Call.new( t )
      when options[:newl_kw] then push_oper.() until oper_stack.empty?
      when options[:digit] then stack << t.to_s.to_f
      else stack << t
      end
    end
    push_oper.() until oper_stack.empty?
    Container.new(stack: stack)

  end
end





















require 'ap'
body, args = Parser::parse_all(File.read('code.rb'))
# ap body
# args = Container.new(knowns: {
  # :+     => Operators::Add,
  # :'='   => Operators::Assign,
  # :'cmp' => Operators::Compare,
  # :'index_stack' => Functions::IndexStack,
  # :'index_knowns' => Functions::IndexKnowns,
  # :'index' => Functions::Index,
  # :'disp' => Functions::Display,
# })
start_args = args.clone
body.call(args)
puts "\n----\n\n"
ap args.stack
ap args.knowns.reject{ |x| start_args.knowns.include?(x) }












