require_relative 'plugin_module'

require_relative 'comments/inline'
require_relative 'comments/block'

module Comments
  extend PluginModule

  PLUGINS = [Inline, Block]

end