require_relative 'plugin_module'

require_relative 'booleans/true'
require_relative 'booleans/false'
require_relative 'booleans/null'

module Booleans
  extend PluginModule

  PLUGINS = [True, False, Null]

end