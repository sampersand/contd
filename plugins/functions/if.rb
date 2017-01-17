require_relative 'functions_extended'
require_relative 'function'

module Functions::If
  extend Functions

  FUNCTION = Function.new( 'if' ){ |args, current|
   args.pr 'args'
   current.pr 'current'
   
   exit 9
  }
  
end


















