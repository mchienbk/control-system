function [yprime] = pend(t, y)
global l1
global l2
global m1
global m2
global g
global torque1 torque2;
l1 = 1;
l2 = 2;
m1 = 2;
m2 = 1;
g = 9.8;
torque1 = 1;
torque2 = 2;

y_prime=zeros(4,1);
a = (m1+m2)*l1 ;
b = m2*l2*cos(y(1)-y(3)) ;
c = m2*l1*cos(y(1)-y(3)) ;
d = m2*l2 ;
e = -m2*l2*y(4)* y(4)*sin(y(1)-y(3))-g*(m1+m2)*sin(y(1)) ;
f = m2*l1*y(2)*y(2)*sin(y(1)-y(3))-m2*g*sin(y(3)) ;

yprime(1) = y(2);
yprime(2)= (torque1-(e*d-b*f))/(a*d-c*b) ;

yprime(3)= y(4) ;
yprime(4)= (torque2 -(a*f-c*e))/(a*d-c*b) ;
yprime=yprime';

end
