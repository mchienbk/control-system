%Example 8.1
%Model reference adaptive control
%Tien 2002.01.15

close all
clear all

%sampling time
tmax=3;
dt=0.01;
n=round(tmax/dt);

%reference data
for i=1:n
   t(i)=(i-1)*dt;
   %r(i)=0;              x(1)=0.5;    xm(1)=0.5;
   r(i)=sin(4*t(i));    x(1)=0.0;   xm(1)=0.0;
end;

%Controller parameters
m=2;
lamda=6;
lamda1=10;
lamda2=25;
gamma=0.5;

%initial values
mh(1)=0;
dx(1)=0;    dxm(1)=0;
s(1)=(dx(1)-dxm(1))+lamda*(x(1)-xm(1));
mt(1)=mh(1)-m;
u(1)=0;

for i=2:n 
   %reference model dynamics
   d2xm(i)=-lamda1*dxm(i-1)-lamda2*xm(i-1)+lamda2*r(i-1);
   dxm(i)=d2xm(i)*dt+dxm(i-1);
   xm(i)=dxm(i-1)*dt+xm(i-1);
   
   %system dynamics
   d2x(i)=u(i-1)/m;
   dx(i)=d2x(i)*dt+dx(i-1);
   x(i)=dx(i-1)*dt+x(i-1);
   
   %tracking error
   xt(i)=x(i)-xm(i);
   dxt(i)=dx(i)-dxm(i);
   d2xt(i)=d2x(i)-d2xm(i);
   
   %update law
   v(i)=d2xm(i)-2*lamda*dxt(i)-lamda^2*xt(i);
   s(i)=(-lamda*s(i-1)+mt(i-1)*v(i-1)/m)*dt+s(i-1);
   mh(i)=-(gamma*s(i)*v(i))*dt+mh(i-1);
   mt(i)=mh(i)-m;
   
   %controller
   u(i)=mh(i)*(d2xm(i)-2*lamda*dxt(i)-lamda^2*xt(i));
end;

plot(t,x,t,xm);
%axis([0 3 -1 0.6]);
axis([0 3 -0.8 0.8]);
xlabel('Time (s)'); ylabel('Tracking Performance xm,x');
figure;plot(t,mh);
axis([0 3  0 2.5]); 
xlabel('Time (s)'); ylabel('Parameter Estimation m');
hold on;	plot([0,3],[m,m]);
