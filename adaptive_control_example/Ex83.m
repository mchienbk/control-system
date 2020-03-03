%Example 8.3
%Model reference adaptive control
%First-order linear system
%Tien 2002.01.16

close all
clear all

%sampling time
tmax=10;
dt=0.01;
n=round(tmax/dt);

%reference data
for i=1:n
   t(i)=(i-1)*dt;
   %r(i)=4*sin(3*t(i));
   r(i)=4;
end;

%system & reference model parameters
ap=-1;  bp=3;
am=4;   bm=4;

%Controller parameters
gamma=2;

%initial values
y(1)=0; ym(1)=0;
e(1)=0;
arh(1)=0;
ayh(1)=0;
u(1)=0;
ar=bm/bp;
ay=(ap-am)/bp;

for i=2:n
   %system dynamics
   y(i)=(-ap*y(i-1)+bp*u(i-1))*dt+y(i-1);
   
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

plot(t,y,t,ym);				xlabel('Time (s)'); ylabel('Tracking Performance ym,y');
figure;plot(t,arh,t,ayh);	xlabel('Time (s)'); ylabel('Parameter Estimation ar,ay');
hold on;	plot([0,10],[ar,ar]);    plot([0,10],[ay,ay])
