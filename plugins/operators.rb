require_relative 'plugin_module'

require_relative 'operators/math'
require_relative 'operators/misc'

module Operators
  extend PluginModule

  PLUGINS = [Math, Misc]

end
