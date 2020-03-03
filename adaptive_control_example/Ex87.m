%Example 8.7
%Model reference adaptive control
%Rohrs's example
%Tien 2002.01.18

close all
clear all

%sampling time
tmax=80;
dt=0.001;
n=round(tmax/dt);

%reference data
for i=1:n
   t(i)=(i-1)*dt;
   r(i)=2;
end;

%system & reference model parameters
ap=1;
bp=2;	%=kp
am=3;
bm=3;	%=km
a1=-(30+ap);
a2=-(30*ap+229);
a3=-229*ap;
a4=229*bp;

%Controller parameters
gamma=1;

%initial values
y(1)=0;
dy(1)=0;
d2y(1)=0;
ym(1)=0;
e(1)=0;
arh(1)=0;
ayh(1)=0;
u(1)=0;
ar=-bm/bp;
ay=(ap-am)/bp;

for i=2:n
   
   %system dynamics
   d2y(i)=(a1*d2y(i-1)+a2*dy(i-1)+a3*y(i-1)+a4*u(i-1))*dt+d2y(i-1);
   dy(i)=d2y(i-1)*dt+dy(i-1);
   y(i)=dy(i-1)*dt+y(i-1);
   y(i)=y(i)+0.005*sin(16.1*t(i));		%including measurement noise
   
   %refernce model dynamics
   ym(i)=(-am*ym(i-1)+bm*r(i-1))*dt+ym(i-1);
      
   %error dynamics
   e(i)=y(i)-ym(i);
      
   %adaptation laws
   arh(i)=(-sign(bp)*gamma*e(i-1)*r(i-1))*dt+arh(i-1);
   ayh(i)=(-sign(bp)*gamma*e(i-1)*y(i-1))*dt+ayh(i-1);
   
   %controller
   u(i)=arh(i)*r(i)+ayh(i)*y(i);
   
end;

plot(t,y,t,ym);				xlabel('y,ym');
figure;plot(t,arh,t,ayh);	xlabel('parameter estimation');
