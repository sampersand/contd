class PreCommand
  # require_relative 'builtins'

  def self.from(raw_cmd)
    puts raw_cmd
    new(raw_cmd)
  end

  def initialize(cmd, *args)
    @cmd = cmd
    @args = args
  end
  def call(results)

  end
end
    # def handle_precommand(line, results)
    #   to_precommand = get_precommand(parsed)
    #   raise "Unknown precommand `#{parsed}`" unless to_precommand
    #   results[ get_precommand_key(to_precommand) ] = to_precommand
    # end

    # def get_precommand(parsed); Builtins.const_get(parsed) end
    # def get_precommand_key(to_precommand); to_precommand.name end

