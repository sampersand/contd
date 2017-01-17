require_relative 'plugin_module'

require_relative 'keywords/get'
require_relative 'keywords/call'
require_relative 'keywords/newline'
require_relative 'keywords/comma'

module Keywords
  extend PluginModule

  PLUGINS = [Get, Newline, Comma]
  # PLUGINS = [Get, Call, Newline]

end




















