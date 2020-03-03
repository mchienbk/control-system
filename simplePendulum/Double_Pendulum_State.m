function Theta = Double_Pend(t,x)
global l1 l2
global m1 m2
global g
global torque1 ;
Theta(2,1) = 0; Theta(4,1) = 0;

Theta(1,1) = x(2);
Theta(2,1) = torque1 - (m1 + m2)*g*l1*sin(x(1)*pi/180) ...
            - m2*l1*l2*(Theta(4,1)*cos((x(1)-x(2))*pi/180) + x(3)^2*sin((x(1)-x(2))*pi/180));
Theta(3,1) = x(4);
Theta(4,1) = (torque2/m2 - g*l2*sin(x(2)*pi/180) ...
            - l1*l2*(Theta(2,1)*cos((x(1)-x(2))*pi/180) - x(2)^2*sin((x(1)-x(2))*pi/180)))...
            /l2^2;      
