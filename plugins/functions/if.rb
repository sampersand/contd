require_relative 'functions_extended'
require_relative 'function'

module Functions::If
  extend Functions

  FUNCTION = Function.new( 'if' ){ |args, current|

    if_false = args.stack.length == 3 ? args.pop : nil
    if_true = args.pop
    cond = args.pop
    cond = cond.call(Container.new, current).pop
    if cond
      if_true
    elsif if_false
      if_false
      # if_false.call(Container.new, current)
    else
      nil
    end

  }

end


















