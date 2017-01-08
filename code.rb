#!INCLUDE +
#!INCLUDE =
#!INCLUDE *
#!INCLUDE /
#!INCLUDE .
#!INCLUDE disp
#!INCLUDE switch


Car = {
  wheels = 4;
  doors = 2;
  mpg = 25;
  maker = 'honda';
  calculate_gas = {
    mph! * time! / Car!.mpg;
  };
};

get_gas = Car!.calculate_gas;
{mph=3; time=4}get_gas!@;
{mph=3; time=4}()(Car!.calculate_gas)@@;




# 10 m/h 
# 5 hrs 
# 25 m/g

































