require_relative 'plugin_module'

require_relative 'operators/math'
require_relative 'operators/assign'
require_relative 'operators/call'

module Operators
  extend PluginModule

  PLUGINS = [Math, Assign, Call]

end
