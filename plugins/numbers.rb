require_relative 'plugin_module'

require_relative 'numbers/whole'
require_relative 'numbers/radix'

module Numbers
  extend PluginModule

  PLUGINS = [Radix, Whole]

end