%Example 7.3
%Sliding mode control
%with sturation control and time-varying boundary layer
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

%initial values
x(1)=xd(1);
dx(1)=dxd(1);
xt(1)=x(1)-xd(1);
dxt(1)=dx(1)-dxd(1);
phi(1)=eta/lamda;
kx(1)= 0.5*dx(1)^2 *abs(cos(3*x(1))) +eta;
kxd(1)=0.5*dxd(1)^2*abs(cos(3*xd(1)))+eta;
kb(1)=kx(1)+kxd(1)+lamda*phi(1);
s(1)=dxt(1)+lamda*xt(1);
fh(1)=-1.5*dx(1)^2*cos(3*x(1));
% u(1)=-fh(1)+d2xd(1)-lamda*dxt(1)-kb(1)*tsat(s(1)/phi(1));
   if abs(s(1)/phi(1)) <=1 
       u(1)=-fh(1)+d2xd(1)-lamda*dxt(1)-kb(1)*(s(1)/phi(1)); 
   else
       u(1)=-fh(1)+d2xd(1)-lamda*dxt(1)-kb(1)*sign(s(1)/phi(1)); 
   end
a(1)=abs(sin(t(1)))+1;

for i=2:n
   %system dynamics
   a(i)=abs(sin(t(i)))+1;
%    a(i)=2;
   dx(i)=(-a(i-1)*dx(i-1)^2*cos(3*x(i-1))+u(i-1))*dt+dx(i-1);
   x(i)=dx(i-1)*dt+x(i-1);
   
   %tracking error
   xt(i)=x(i)-xd(i);
   dxt(i)=dx(i)-dxd(i);
   
   %boundary layer dynamics
   phi(i)=(-lamda*phi(i-1)+kxd(i-1))*dt+phi(i-1);
      
   %controller
   kx(i)= 0.5*dx(i)^2 *abs(cos(3*x(i))) +eta;
   kxd(i)=0.5*dxd(i)^2*abs(cos(3*xd(i)))+eta;
   kb(i)=kx(i)+kxd(i)+lamda*phi(i);
   s(i)=dxt(i)+lamda*xt(i);
   fh(i)=-1.5*dx(i)^2*cos(3*x(i));
%    u(i)=-fh(i)+d2xd(i)-lamda*dxt(i)-kb(i)*tsat(s(i)/phi(i));
      if abs(s(i)/phi(i)) <=1 
          u(i)=-fh(i)+d2xd(i)-lamda*dxt(i)-kb(i)*(s(i)/phi(i)); 
      else
          u(i)=-fh(i)+d2xd(i)-lamda*dxt(i)-kb(i)*sign(s(i)/phi(i)); 
      end
   
end;

plot(t,x-xd,'LineWidth',2);                   xlabel('Time, s');	ylabel('Tracking Error x-xd');
figure;plot(t,x,t,xd,'LineWidth',2);          xlabel('Time, s');  ylabel('x, xd');
figure;plot(t,u,'LineWidth',2);               xlabel('Time, s');	ylabel('Control Input u');
figure;plot(t,phi,t,-phi,t,s,'LineWidth',2);  xlabel('Time, s');	ylabel('phi, s, -phi');
