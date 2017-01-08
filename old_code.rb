#!INCLUDE +
#!INCLUDE =
#!INCLUDE *
#!INCLUDE /
#!INCLUDE .
#!INCLUDE disp
#!INCLUDE switch


car = {
  wheels = 4;
  doors = 2;
  mpg = 25;
  maker = 'honda';
};
calculate_gas = {
  mph! * time! / car!.mpg
};
{mph=3; time=4} calculate_gas!@
# (car!.maker) disp!@




# 10 m/h 
# 5 hrs 
# 25 m/g

































