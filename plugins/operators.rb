require_relative 'plugin_module'

require_relative 'operators/math'
require_relative 'operators/misc'
require_relative 'operators/comparison'

module Operators
  extend PluginModule

  PLUGINS = [Comparison, Math, Misc]

end
