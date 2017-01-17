

require_relative 'core/parser'

input = '


x = 3;
y = \'4.5\'
#foo
/* bar
baz */
z = (6.7 + 9) * 3.2
w = ten0_1 !
v = 
ab'


input = '3 + 42 * 5'
input = '(3 (4)-!@)+!@'
input = '(9 (4 5)-!@)+!@'
input = '
(foo {x!})=!@;
((x 3)=!@)foo!@
'

# input = ' (!!) @ ( y = 4; x = y; x) '
# input = '
# car = {
#   wheels = 4;
# };

# car! @ ()
# '

input = '
foo = {
  x = !;
  y = !;
  z = !;
}
foo! @ (4 5 6)
'

input = '
my_function = {
  wheels = 4;
  maker = "honda";
  0 = 4;
  4
  # 2
  # 4 + x! ^ 3
};
args=(x=3;);
y = my_function! @ args!;
y!.$ 0
'

input = '
foo = { x! + 4 };
bar = { x! * 3 };
bar! @ (x = foo!@(x=2;).0;).0
'
input = '
# foo = { x! + y! };
# bar = { x! * 3 };

# foo!@(x = 4, y = 9) . wheels


car = {
  wheels = 4;
  mpg = 4;
  drive = {
    "vroom vroom"
  };
};
;
#disp! @ (car!@().drive)

'

input = <<FINISH

4 < 3
/*
x=3;
if!:([x > 3],
  {'x > 3'},
  {'x < 3'}
)
*/
FINISH

require_relative 'plugins/standard'
parser = Parser.new(input)
parser.add Standard

res = parser.run
body, result = res.split


body.pr 'Body'

res = body.call(Container.new, result)
res.pr "result"



