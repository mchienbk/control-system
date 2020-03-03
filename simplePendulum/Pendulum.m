function Theta = Pendulum(t,x)
global torque;
global g;
global l;
global m;
Theta(1,1) = x(2);
Theta(2,1) = torque/(m*l^2) - (g/l)*sin(x(1)*pi/180);
