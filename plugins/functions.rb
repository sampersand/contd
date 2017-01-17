require_relative 'plugin_module'

require_relative 'functions/if'
require_relative 'functions/display'

module Functions
  extend PluginModule

  PLUGINS = [If, Display]

end