
module Parser
  require_relative 'objects/keyword'
  require_relative 'objects/identifier'
  require_relative 'objects/container'
  require_relative 'builtins/operators'
  require_relative 'builtins/functions'

  module_function

  def handle_include(acc, knowns)
    acc = acc[acc.index(' ')+1, acc.length]
    
    # :+     => Operators::Add,
  end

  def tokenize(body, **options)

    res = ['']
    knowns = {}
    body = body.each_char.to_a

    until body.empty?
      c = body.shift
      case c
      when options[:left_paren], options[:right_paren],\
            options[:get_kw], options[:call_kw], options[:newl_kw]
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
        =/
    options[:digit] ||= /[\d]+(?:.\d+)?/


    tokens, knowns = tokenize(body, **options)
    res = parse(tokens, **options)

    res.knowns.update(knowns)
    res
  end
  def parse(tokens, **options)

    # +-*/ ** % << >> & | ^ ~ 
    # +-*/ % & | ^

    stack = []
    oper_stack = []

    until tokens.empty? 
      t = tokens.shift
      case t
      when options[:left_paren] then stack << parse(tokens, **options)
      when options[:right_paren] then break
      when options[:get_kw] then stack << Keyword::Get.new( t )
      when options[:call_kw] then stack << Keyword::Call.new( t )
      when options[:newl_kw] then stack << Keyword::Newline.new( t )
      when options[:digit] then stack << t.to_f
      else
        stack << t.to_sym
      end
    end
    stack << oper_stack.pop until oper_stack.empty?
    Container.new(stack: stack)

  end
end





















require 'ap'
body = Parser::parse_all(File.read('code.rb'))
# ap body
args = Container.new(knowns: {
  # :+     => Operators::Add,
  # :'='   => Operators::Assign,
  # :'cmp' => Operators::Compare,
  # :'index_stack' => Functions::IndexStack,
  # :'index_knowns' => Functions::IndexKnowns,
  # :'index' => Functions::Index,
  # :'disp' => Functions::Display,
})
start_args = args.clone
body.call(args)
puts "\n----\n\n"
ap args.stack
ap args.knowns.reject{ |x| start_args.knowns.include?(x) }












