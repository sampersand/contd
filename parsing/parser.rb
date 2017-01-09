class Parser
  require_relative '../core/container'
  require_relative 'pre_command'
  def initialize(body)
    @body = body
    @results = Container.new
  end

  def execute
    parse_precommands
    parse
    @results
  end

  private

  def parse_precommands
    @body = @body.each_line.collect do |line|
              if is_precommand? line
                process_precommand *split_precommand(line)
              else
                line
              end
            end.compact.join
  end
    def precommand_prefix
      '#! '
    end

    def is_precommand?(text)
      text.start_with? precommand_prefix
    end

    def split_precommand(text)
      text.gsub(precommand_prefix, '').strip.split(/ /)
    end

    def process_precommand(cmd, *args)
      puts "TODO: process_precommand(#{cmd}, *#{args})"
    end

  def parse
    last = ''
    @body.each_char do |char|
    end

  end

end



parser = Parser.new('''
#! Inlcude Add Sub
#! Number
+! @ (3 4)
''')

body, args = parser.execute
puts '----'
p body, args
puts '----'
exit

results = Container.new
body.call(args: args, results: results)
puts results



