require_relative '../plugin_module'

require_relative 'comparison/less'
require_relative 'comparison/greater'
require_relative 'comparison/less_equal'
require_relative 'comparison/greater_equal'
require_relative 'comparison/equal'
require_relative 'comparison/not_equal'

module Operators
  module Comparison
    extend PluginModule

    PLUGINS = [LessEqual, GreaterEqual, Less, Greater, Equal, NotEqual]
    
  end
end