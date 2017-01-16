require_relative 'plugin_module'

require_relative 'text/single_quote'
require_relative 'text/double_quote'

module Text
  extend PluginModule

  PLUGINS = [SingleQuote, DoubleQuote]

end