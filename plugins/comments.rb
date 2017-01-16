require_relative 'comments/inline'
require_relative 'comments/block'

module Comments

  module_function

  def handle_next(parser)
    Comments::Inline.handle_next(parser) ||
    Comments::Block.handle_next(parser)
  end

end