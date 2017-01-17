require_relative 'functions_extended'
require_relative 'function'

module Functions::If
  extend Functions

  FUNCTION = Function.new( 'if' ){ |args, current|
    args = args.pop #is this right?
    if_false = args.stack.length == 3 ? args.pop : nil

    if_true = args.pop
    condition = args.pop
    if condition
      if_true.call(Container.new, current)
      current['y']=4

    elsif if_false
      if_false
    else
      nil
    end

  }
  
end







