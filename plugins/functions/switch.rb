require_relative 'functions_extended'
require_relative 'function'

module Functions::Switch
  extend Functions

  ARG_LENGTH = 2

  FUNCTION = Function.new( 'switch' ){ |args, current|
    switch_on = args.pop.call(Container.new, current).pop
    body = args.pop.call(Container.new, current)
    current << body[switch_on]

  }  
end


















