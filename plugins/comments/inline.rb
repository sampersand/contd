require_relative '../plugin_module'

require_relative 'inline/c_style'
require_relative 'inline/pound'

module Comments::Inline
  extend PluginModule

  PLUGINS = [CStyle, Pound]

end
