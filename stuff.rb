
2 + 3 * 4
(2 + 3) * 4

2 3 4 * +
2 3 + 4 *


stack   | left_to_do
        | 2 3 4 * +
2       | 3 4 * +
2 3     | 4 * +
2 3 4   | * +
2 12    | +
24      |


x 2 3 + =

stack   | left_to_do  | knowns
        | x 2 3 + =   |
x       | 2 3 + =     |
x 2     | 3 + =       |
x 2 3   | + =         |
x 6     | =           |
        |             | x = 6





0 = 4 + 3
* = 4 y 2






(
  *
  (4 2)
  +, GET, CALL
), =, GET, CALL 



foo = {
  x + 3 * 4
}

foo(x=9)


foo = def {
  x + 3 * 4
}

car = class {
  wheels = 4,
  seats = 2,
  maker = 'honda'
  * = 5,
  93 = 19,
  0 = 6
}
arr = [9, 10, 234]

car[93] # => 19
car[0] # => 6
arr[0] # => 9

spam = {
  4,
  0 = 5
  colour = red
  lenght = { ... }
}
spam.0       # => 4
spam[0]      # => 5

spam.0       # => 5
spam[0]      # => 4
spam[length]      # => 4


















