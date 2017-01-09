require_relative 'core/container'
def stack(*args) Container.new(stack: args) end
def knowns(**kwargs) Container.new(knowns: kwargs) end
def  get; Keyword::Get.new end
def call; Keyword::Call.new end
def newl; Keyword::Newline.new end

require_relative 'std/operators'

body = stack(
 :'=',
 get,
 call,
 stack(:y, 
       :+,
       get, 
       call,
       stack(:x, get, 4)),
 newl,
)
args = knowns(x: 3,
              '+': Std::Functions::Operators::Add,
              '=': Std::Functions::Operators::Assign,
              )
results = stack
body.call(args: args, results: results)
p results