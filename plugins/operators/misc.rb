require_relative '../plugin_module'

require_relative 'misc/assign'
require_relative 'misc/call'
require_relative 'misc/index'

module Operators
  module Misc
    extend PluginModule

    PLUGINS = [Assign, Call, Index]
  end
end