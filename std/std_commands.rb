module Std
  module PreCommands

    module_function

    def [](item)
      DEFAULT_PRECOMMANDS[item]
    end

    KNOWNS = {}

    require_relative 'operators'

    KNOWNS.update Std::Functions::Operators.constants.collect{ |c|
      [c, Std::Functions::Operators.const_get(c)]
    }.to_h

    DEFAULT_PRECOMMANDS = {
      'Include': proc{ |*names, results:, parser:|
        names.each do |name_alias|
          name, name_alias = name_alias.to_s.split('=', 2).collect(&:to_sym)
          value = KNOWNS[name]
          raise "Unknown Include `#{name}`" unless value
          results[name_alias || name] = value
        end
      },
      'Numbers': proc{ |results:, parser:| 
        parser.options[:get_identifier].unshift proc{ |sym, results| 
          begin
            results << Float(sym.to_s)
          rescue ArgumentError => e
            nil
          end
        }
      },
      'Operators': proc{ |*names, results:, parser:| 
        parser.options[:get_identifier].unshift lambda{ |sym, results|
          if results.knowns.include?(sym) && results[sym].is_a?(Std::Functions::Operators::Operator)
            results << sym << Keyword::Get.new << Keyword::Call.new
          end
        }
      }
      
    }
  end
end















