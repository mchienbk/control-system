% Ex77
% Minh Chien

%Example 7.2
%Sliding mode control
%with sturation control
%Tien 2002.01.10

close all
clear all

%sampling time
tmax=4;
dt=0.001;
n=round(tmax/dt);

%reference data
w=pi/2;
xd(1)=0;
dxd(1)=w;
d2xd(1)=0;
for i=2:n
   t(i)=(i-1)*dt;
   xd(i)=sin(w*t(i));
   dxd(i)=(xd(i)-xd(i-1))/dt;
   d2xd(i)=(dxd(i)-dxd(i-1))/dt;
end

%Controller parameters
lamda=20;
eta=0.1;
phi=1;

%initial values
x(1)=xd(1);
dx(1)=dxd(1);
xt(1)=x(1)-xd(1);
dxt(1)=dx(1)-dxd(1);
% F(1)=0.5*dx(1)^2*abs(cos(3*x(1)));
F(1) = abs(x(1))*dx(1)^2 + 3*x(1)^2*abs(x(1)*cos(2*x(1)));
k(1)=F(1)+eta;
s(1)=dxt(1)+lamda*xt(1);
fh(1)=-2*x(1)^3*cos(2*x(1));
v(1)=-fh(1)+d2xd(1)-lamda*dxt(1)-k(1)*sign(s(1)/phi); 
%    if abs(s(1)/phi) <=1
%        v(1)=-fh(1)+d2xd(1)-lamda*dxt(1)-k(1)*(s(1)/phi); 
%    else
%        v(1)=-fh(1)+d2xd(1)-lamda*dxt(1)-k(1)*sign(s(1)/phi); 
%    end
a(1)= 1 - 2*rand(1);
b(1)= 5 - 6*rand(1);
u(1) = v(1);
for i=2:n
   
   %system dynamics
   a(i)= 1 - 2*rand(1);
   b(i)= 5 - 6*rand(1);
   dx(i)=(-a(i-1)*abs(x(i-1))*dx(i-1)^2 - b(i-1)*x(i-1)^3*cos(2*x(i-1))+ v(i-1))*dt + dx(i-1);
   x(i)=dx(i-1)*dt+x(i-1);
   
   %tracking error
   xt(i)=x(i)-xd(i);
   dxt(i)=dx(i)-dxd(i);
   
   %controller
%    F(i)=0.5*dx(i)^2*abs(cos(3*x(i)));
   F(i) = abs(x(i))*dx(i)^2 + 3*x(i)^2*abs(x(i)*cos(2*x(i)));
   k(i)=F(i)+eta;
   s(i)=dxt(i)+lamda*xt(i);
   fh(i)=-2*x(i)^3*cos(2*x(i));
   v(i)=-fh(i)+d2xd(i)-lamda*dxt(i)-k(i)*sign(s(i)/phi);
%    if abs(s(i)/phi) <=1
%        v(i)=-fh(i)+d2xd(i)-lamda*dxt(i)-k(i)*(s(i)/phi);
%    else
%        v(i)=-fh(i)+d2xd(i)-lamda*dxt(i)-k(i)*sign(s(i)/phi);
%    end
   u(i) = 1/5*(-u(i-1)+ v(i-1))*dt + u(i-1);
end;

plot(t,x-xd,'LineWidth',2);           xlabel('Time, s');	ylabel('Tracking Error x-xd');
figure;plot(t,x,t,xd,'LineWidth',2);  xlabel('Time, s');  ylabel('x, xd');
figure;plot(t,v,'LineWidth',2);	    xlabel('Time, s');	ylabel('Control Variable v');
figure;plot(t,u,'LineWidth',2);	    xlabel('Time, s');	ylabel('Control Input u');

