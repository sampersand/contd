require_relative 'plugin_module'

require_relative 'operators/math'
require_relative 'operators/assign'

module Operators
  extend PluginModule

  PLUGINS = [Math, Assign]

end
