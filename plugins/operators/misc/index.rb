require_relative '../../plugin_module'

require_relative 'index/both'
require_relative 'index/stack'
require_relative 'index/known'

module Operators::Index
  extend PluginModule

  PLUGINS = [Stack, Known, Both]

end