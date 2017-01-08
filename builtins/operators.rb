module Operators
  Add = proc{ |results| results << results.pop(-2) + results.pop }
end