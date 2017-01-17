require_relative 'functions_extended'
require_relative 'function'

module Functions::Display
  extend Functions

  FUNCTION = Function.new( 'disp' ){ |args, current|
    sep = args['sep'] || " "
    end_ = args['end'] || "\n"
    print args.pop.to_s + sep until args.stack.length == 1
    print args.pop.to_s + end_
  }
  
end


















