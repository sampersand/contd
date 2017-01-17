require_relative 'function_extended'
require_relative 'function'

module Functions::Display
  extend Functions

  FUNCTION = Function.new( 'disp' ){ |args, current|
    p args.pop
    exit
    
   puts  'todo'
   exit 9
  }
  
end


















