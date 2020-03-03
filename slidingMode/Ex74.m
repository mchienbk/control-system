%Example 7.4
%Sliding mode control
%with sturation control and time-varying boundary layer
%Tien 2002.01.10

close all
clear all

%sampling time
tmax=6;
dt=0.01;
n=round(tmax/dt);

%reference data
xd(1)=0;
dxd(1)=0;
d2xd(1)=0;
a=2;		%m/s2
v=4;		%m/s
for i=2:n
   t(i)=(i-1)*dt;
   if t(i)<=2
      d2xd(i)=a;
      dxd(i)=dxd(i-1)+d2xd(i-1)*dt;
      xd(i)=xd(i-1)+dxd(i-1)*dt;
   elseif (2<t(i)) & (t(i)<=4)
      d2xd(i)=0;
      dxd(i)=v;
      xd(i)=xd(i-1)+dxd(i-1)*dt;
   else
      d2xd(i)=-a;
      dxd(i)=dxd(i-1)+d2xd(i-1)*dt;
      xd(i)=xd(i-1)+dxd(i-1)*dt;
   end;
end;

%Controller parameters
lamda=20;
eta=1.2;
mh=sqrt(5);
ch=1;

%initial values
x(1)=xd(1);
dx(1)=dxd(1);
xt(1)=x(1)-xd(1);
dxt(1)=dx(1)-dxd(1);
phi(1)=eta/lamda;
dphi(1)=0;
m(1)=3+1.5*sin(abs(dx(1))*t(1));
c(1)=1.2+0.2*sin(abs(dx(1))*t(1));
kx(1)=0.5*dx(1)^2+5*eta+(5-sqrt(5))*abs(d2xd(1)-lamda*dxt(1));
kxd(1)=0.5*dxd(1)^2+5*eta+(5-sqrt(5))*abs(d2xd(1)-lamda*dxt(1));
kb(1)=kx(1)-dphi(1);
s(1)=dxt(1)+lamda*xt(1);
uh(1)=ch*dx(1)*abs(dx(1))+mh*(d2xd(1)-lamda*dxt(1));
u(1)=uh(1)-kb(1)*tsat(s(1)/phi(1));

for i=2:n
   
   %system dynamics
   dx(i)=(-c(i-1)/m(i-1)*dx(i-1)*abs(dx(i-1))+1/m(i-1)*u(i-1))*dt+dx(i-1);
   x(i)=dx(i-1)*dt+x(i-1);
   
   %uncertaities
   m(i)=3+1.5*sin(abs(dx(i))*t(i));
   c(i)=1.2+0.2*sin(abs(dx(i))*t(i));
   
   %tracking error
   xt(i)=x(i)-xd(i);
   dxt(i)=dx(i)-dxd(i);
   
   %boundary layer dynamics
   phi(i)=(-lamda*phi(i-1)+kxd(i-1))*dt+phi(i-1);
   dphi(i)=(phi(i)-phi(i-1))/dt;

   %controller
   kx(i)=0.5*dx(i)^2+5*eta+(5-sqrt(5))*abs(d2xd(i)-lamda*dxt(i));
   kxd(i)=0.5*dxd(i)^2+5*eta+(5-sqrt(5))*abs(d2xd(i)-lamda*dxt(i));
   kb(i)=kx(i)-dphi(i);
   s(i)=dxt(i)+lamda*xt(i);
   uh(i)=ch*dx(i)*abs(dx(i))+mh*(d2xd(i)-lamda*dxt(i));
   u(i)=uh(i)-kb(i)*tsat(s(i)/phi(i));

end;

plot(t,x-xd,'LineWidth',2);					xlabel('Time, s');	ylabel('Tracking Error x-xd');
figure;plot(t,x,t,xd,'LineWidth',2);			xlabel('Time, s');  ylabel('x, xd');
figure;plot(t,u,'LineWidth',2);				xlabel('Time, s');	ylabel('Control Input u');
figure;plot(t,phi,t,-phi,t,s,'LineWidth',2);	xlabel('Time, s');	ylabel('phi, s, -phi');
