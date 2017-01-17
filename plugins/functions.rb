require_relative 'plugin_module'

require_relative 'functions/if'
require_relative 'functions/display'
require_relative 'functions/switch'

module Functions
  extend PluginModule

  PLUGINS = [If, Display, Switch]

end