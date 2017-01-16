require_relative 'plugin_module'

require_relative 'containers/parens'
require_relative 'containers/braces'
require_relative 'containers/brackets'

module Containers
  extend PluginModule

  PLUGINS = [Brackets, Parens, Braces]

end